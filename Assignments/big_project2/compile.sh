# Compile the document with xelatex
xelatex main.tex

# Run biber for bibliography processing
biber main

# Compile again to integrate bibliography
xelatex main.tex

# Compile again to resolve references
xelatex main.tex