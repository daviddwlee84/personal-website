# NOTE: Unused now
# https://miktex.org/download
docker run -ti `
    -v "miktex:/miktex/.miktex" `
    -v "$(Get-Location):/miktex/work" `
    miktex/miktex `
    xelatex resume.tex

start resume.pdf
