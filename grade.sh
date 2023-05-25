CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area
mkdir student-submission

git clone $1 student-submission 
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
#set -e
files=`find student-submission`
for file in $files
do
    echo $file
    if [[ $file == *ListExamples.java* ]]
    then   
        cp $file grading-area 
        cp TestListExamples.java grading-area
        cp -r lib grading-area
        echo "found right file"
        break
    else
        echo "wrong file type"
    fi
done

#javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar grading-area/*.java
cd grading-area
javac -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar *.java 

java -cp .:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar org.junit.runner.JUnitCore TestListExamples > file.txt 2>&1
# javac grading-area/ListExamples.java grading-area/TestListExamples.java

# grep "Tests run:" file.txt | awk '{print $3,$5}' > calc.txt
if grep -q "Tests run" "file.txt"; then     
    grep "Tests run:" file.txt | awk '{sub(/,/, "", $3); print $3,$5}' > calc.txt
    num1=$(awk '{print $1}' calc.txt)
    num2=$(awk '{print $2}' calc.txt)

    result=$(($num2 / $num1))
    echo $((1-$result))
elif 
else
    echo "100"
fi
# grep "Tests run:" file.txt > calc.txt
# Tests run: 1,  Failures: 1

