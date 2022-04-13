_aws_sso_util_completion() {
    local IFS=$'
'
    COMPREPLY=( $( env COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   _AWS_SSO_UTIL_COMPLETE=complete $1 ) )
    return 0
}

complete -F _aws_sso_util_completion aws-sso-util
