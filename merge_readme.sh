git checkout master -- README.md
rm index.md
echo "---\nlayout: default\n---" >> index.md
cat README.md >> index.md
rm README.md
