
#!/bin/bash

echo "This is the default process. It will create a file, write 'I'm a learner mate' to it, print the content, crash, and then restart every 4 seconds."

while true; do
    echo "Default process is running..."
    echo "I'm a learner mate" > learner_file.txt
    cat learner_file.txt
    sleep 4
    echo "Default process has crashed. Restarting..."
    rm learner_file.txt
done
