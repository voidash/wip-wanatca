#! /usr/bin/bash
for file in */*.htm
    do
      markdown=${file%*.htm}.md
      python3 convert.py "$file" | pandoc --from=html --to=markdown_strict+pipe_tables -o "$markdown"
      # html2text "$file" > "$markdown" 
    #   markdownify "$file" > "$markdown" 
      if [ "${markdown#*\/}" == "Author-n-Subs.md" ] 
      then
        # sed 
        sed -i '1,6d' "$markdown"
        sed -i 's/Author:.*/{{< collapsible summary="Author:" >}}/' "$markdown"
        sed -i '/Organization:.*/i{{< \/collapsible >}}/' "$markdown"
        sed -i 's/Organization:.*/{{< collapsible summary="Organization:" >}}/' "$markdown"

        # sed -i 's/$/{{< \/collapsible >}}/' "$markdown"
        echo "{{< /collapsible >}}" >> "$markdown"
      fi
      

      if [ "${file#*\/}" == "Author-n-Text.htm" ] 
      then
        echo $file
        dirs=${file%/*}

        # sed -i '/Last Updated.*/{h};$G' "$markdown"
        # awk '/<table>/{flag=1}; !flag; /<\/table>/{flag=0}' "$markdown" > "$markdown.tmp"
        # awk "/^##/{while(getline line < \"${markdown%Text.md}Subs.md\") print line; next} 1" "$markdown.tmp" > "$markdown"
        # rm "$markdown.tmp"
        # mv "$markdown" "$dirs/"_index.md

        python3 extractor.py "$file" "$dirs/Author-n-Subs.md" > "$dirs/_index.md" 
        sed -i 's/&lt;/</g; s/&gt;/>/g' "$dirs/_index.md"

        sed -i '1 i ---' "$dirs/_index.md"
        sed -i '1 a bookHidden: true' "$dirs/_index.md"
        sed -i '2 a ---' "$dirs/_index.md"
      fi
    done


