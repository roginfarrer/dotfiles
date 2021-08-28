function construct_column_aware_prompt -a prompt_prefix prompt_dir
    set -l prompt_concat "$prompt_prefix$prompt_dir"

    if test (expr length "$prompt_concat") -le $COLUMNS
        echo $prompt_prefix$prompt_dir
    else
        if test (expr length "$prompt_prefix") -le $COLUMNS
            set -l split_prompt_concat (string split "/" $prompt_dir)

            if test (count $split_prompt_concat) -lt 2
                echo (string sub -s 1 -l (math $COLUMNS - (expr length "$prompt_prefix")) $prompt_dir)
            else
                for i in (seq (count $split_prompt_concat))
                    if test (expr length "> $split_prompt_concat[$i]/") -gt $COLUMNS
                        set split_prompt_concat[$i] (string sub -s 1 -l (math $COLUMNS - 8) $split_prompt_concat[$i])'[...]'
                    end
                end

                set -l tmp_lines "$prompt_prefix"

                for item in $split_prompt_concat
                    set -l tmp_line "$tmp_lines$item/"
                    if test (expr length "$tmp_line") -le $COLUMNS
                        set tmp_lines $tmp_line
                    else
                        echo $tmp_lines
                        set tmp_lines "> $item/"
                    end
                end

                set -l tmp_lines_length (expr length "$tmp_lines")
                if test $tmp_lines_length -gt 0
                    echo (string sub -s 1 -l (math $tmp_lines_length - 1) $tmp_lines)
                end
            end
        else
            set -l rec (construct_column_aware_prompt "" $prompt_dir)
            for item in rec
                echo $item
            end
        end
    end
end

