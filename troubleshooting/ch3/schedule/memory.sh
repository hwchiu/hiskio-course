for index in $(seq 1000); do
    value=$(seq -w -s '' $index $(($index + 1000000000)))
    eval array$index=$value
done
