#/bin/bash
rm /home/krasto/workspace/OGC/Pharmagc/UML/png/*png
for svg in /home/krasto/workspace/OGC/Pharmagc/UML/svg/*svg 
do
  png=$(echo $svg | sed "s/svg/png/gi");
  inkscape -w 1080 --export-type png -b white "$svg" -o "$png"
done;
