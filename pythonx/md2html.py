from pathlib import Path
from concurrent import futures
import vim  # type: ignore
import subprocess

wiki_config = vim.eval('g:wiki_config')

md_dir_path = Path(
    wiki_config['home'] + '/' + wiki_config['markdown_dir'])
html_dir_path = Path(
    wiki_config['home'] + '/' + wiki_config['html_dir'])
template_path = Path(
    wiki_config['home'] + '/' + wiki_config['template_path'])
script_path = Path(
    wiki_config['home'] + '/' + wiki_config['script_path'])


def _md2html(md: Path):
    assert str(md).endswith('.md')
    rel = md.relative_to(md_dir_path)
    html = (html_dir_path / str(rel).replace('.md', '.html'))
    html.parent.mkdir(parents=True, exist_ok=True)
    depth = str(rel).count('/')
    subprocess.run([script_path, md, html, template_path, str(depth)])
    print(f'{md} has been converted to html!')


def _changed_sources():
    mds: list[Path] = [p for p in md_dir_path.rglob('*.md')]
    html_stem_dict: dict[str, Path] = {
        p.stem: p for p in html_dir_path.rglob('*.html')}

    for md in mds:
        if md.stem not in html_stem_dict:
            yield md
            continue
        html = html_stem_dict[md.stem]
        md_mtime = md.stat().st_mtime
        html_mtime = html.stat().st_mtime
        # print(f'{md.stem:20s} {md_mtime}   {html_mtime}')
        if md_mtime > html_mtime:
            yield md


def convert_current_buffer():
    bufpath = vim.current.buffer.name
    _md2html(Path(bufpath))


def convert_changed_sources():
    for md in _changed_sources():
        _md2html(md)


def convert_all_sources():
    with futures.ProcessPoolExecutor() as executor:
        executor.map(_md2html, md_dir_path.glob('*.md'))


if __name__ == '__main__':
    # convert_all_sources()
    print(list(_changed_sources()))
    # _md2html(Path('/home/zds/Develop/Wiki/sources/haha/test/md/nice.md'))
    # _md2html(Path('/home/zds/Develop/Wiki/sources/diary/diary.md'))
    # convert_current_buffer()
