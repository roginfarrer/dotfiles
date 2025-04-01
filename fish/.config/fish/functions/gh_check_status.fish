function gh_check_status
    set -f head $(git rev-parse --abbrev-ref HEAD)

    # Get the current timestamp
    set -f current_time (date +%s)

    # Check if we can use the cached result
    if test -n $__FUNCTION_CACHE_RESULT \
            && test (math $current_time - $__FUNCTION_CACHE_TIMESTAMP) -lt 180 \
            && test $head = $__FUNCTION_CACHE_COMMIT_HASH

        # Return the cached result if conditions are met
        echo $__FUNCTION_CACHE_RESULT
        return 0
    end

    set -f _gh_check_passing_icon '✅'
    set -f _gh_check_in_progress_icon '🟡'
    set -f _gh_check_failed_icon '❌'

    set -f content $(gh pr list --head $head -s open --json statusCheckRollup,url,number --jq '.[] | .url as $url | .number as $number | .statusCheckRollup | if (map(.conclusion=="FAILURE") | any) then "'$_gh_check_failed_icon'" elif (map(.status=="IN_PROGRESS") | any) then "'$_gh_check_in_progress_icon'" else "'$_gh_check_passing_icon'" end | . as $conclusion | {url: $url, number: $number, conclusion: $conclusion }' | tr -d '\n')

    # Cache the result, timestamp, and commit hash
    set -g __FUNCTION_CACHE_RESULT $content
    set -g __FUNCTION_CACHE_TIMESTAMP $current_time
    set -g __FUNCTION_CACHE_COMMIT_HASH $head

    if test -n "$content"
        set -l icon $(echo $content | jq -r -e '.conclusion' | tr -d '\n')
        set -l url $(echo $content | jq -r -e '.url' | tr -d '\n')
        set -l number $(echo $content | jq -r -e '.number|tostring' | tr -d '\n')

        # Format output using OSC 8 link spec
        set -l link $(print_link "$url" "#$number")
        set content $icon$link

        # set -g _gh_check_content $content
        set -g __FUNCTION_CACHE_RESULT "$content"

        echo $content
    end
end
