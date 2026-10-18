```
podman run --rm -it -v ./:/data:Z sinux/build123d:v1.3 draftwright --title hello --tolerance "ISO 2768-m" --drawn-by sinux --material "PLA/PETG" --date `date "+%d.%m.%Y"` --frame --zones --projection "first" --text-position above --page A3 --format svg my_file.step
```
