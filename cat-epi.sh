dirbase=$PWD

dirmd=$dirbase/shownotes/md
dirhtml=$dirbase/shownotes/html

css=style.css

cat $dirbase/template.md > index.md
for md in `ls -r $dirmd/*.md`
do
        if [ $md != $dirmd"/template.md" ];then
                html=`echo $md | sed "s@$dirmd@episodes@;s/md/html/g"`
                prefix=`echo $md | sed "s@$dirmd/@@;s/.md//"`
                pandoc $md -s -c $css -o $html
                #cp $html .
                title=`awk '$0~"^### " {gsub("### ","",$0);print $0}' $md`
                summary=`grep -A1 "Summary" $md | tail -n1`
                anchor=`awk '$0~"^<iframe.*/iframe>$" {print $0}' $md`
                echo "### [" $title"]("$html")"
                echo ""
                echo $summary
                echo ""
                echo $anchor
                echo ""
                echo ""
        fi
done >> index.md

echo "" >> index.md
echo "---" >> index.md
echo "" >> index.md


pandoc index.md -s -c $css -A footer.html -o index.html

