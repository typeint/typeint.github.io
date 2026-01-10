rm -rf index.md web
mkdir web
for file in posts/*.md; do
    basename=$(basename "$file")
    date=$(echo "$basename" | cut -d- -f1-3)
    path=$(echo "$basename" | cut -d- -f4- | cut -d. -f1)
    title=$(head -1 "$file" | cut -d" " -f2-)
    echo $date
    echo $path
    mkdir "web/$path"
    set -x; pandoc "$file" --template "template.html" -V "ispost=ispost" -V "title=$title" -V "who=Jim T" -V "date=$date" -o "web/$path/index.html"; set +x
    echo "$date - <a href=\"$path/\">$title</a>\n" >> index.md
    echo >> index.md
    tac index.md > reverse.md
    mv reverse.md index.md
done
for file in others/*.md; do
    basename=$(basename "$file")
    path=$(echo "$basename" | cut -d- -f4- | cut -d. -f1)
    title=$(head -1 "$file" | cut -d" " -f2-)
    echo $path
    mkdir "web/$path"
    set -x; pandoc "$file" --template "template.html" -V "ispost=ispost" -V "title=$title" -V "who=Jim T" -o "web/$path/index.html"; set +x
done
set -x; pandoc "index.md" --template "template.html" -V "who=Jim T" -o "web/index.html"; set +x
rm -f index.md
