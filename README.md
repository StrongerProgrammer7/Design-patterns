<sub>**This work is being done as part of the Course Deisgn patterns on <strong>Ruby</strong> **</sub> 
# Design-patterns
<p>
<a href="https://github.com/StrongerProgrammer7/Design-patterns#-introduction-with-ruby---1lab">Introduction with Ruby</a></br>
<h5>Kernel classes and models</h5>
&emsp;&emsp;<a href="https://github.com/StrongerProgrammer7/Design-patterns#1ex-object-and-clesses">Object and clesses<a/>
&emsp;&emsp;<a href="https://github.com/StrongerProgrammer7/Design-patterns#2ex-reading-view-record-entity">Reading, view, record entity<a/>
</p>
<div>
<h3> Introduction with Ruby - 1lab</h3>
<p>1 Task: <br/><pre>
          1.&emsp;Hello world
          2.&emsp;Accept the username as a program argument.Say hello to the user using string formatting. 
          &emsp;&emsp;&emsp;Ask what language is the user's favorite, in case it is ruby, answer that the user is 
          &emsp;&emsp;&emsp;&emsp;a sucker, otherwise be sure to answer that soon it will be ruby and put 
          &emsp;&emsp;&emsp;&emsp;&emsp;different comments for several languages.
          3.&emsp;Ask user enter ruby language command and OS command. Execute ruby and OS command</pre>
</p>
<p> 2 Task:<br/><pre>
          1.&emsp;Find the sum of prime divisors of a number.
          2.&emsp;Find the number of odd digits of a number greater than 3
          3.&emsp;Find the multiple of such divisors of a number, the sum of the digits less than 
          &emsp; &emsp;the sum of the digits of the original number.
</pre></p>
<p> 3 Task:<br/><pre>
          1.&emsp;Write methods that find the minimum, elements, number of the first positive element.
          &emsp; &emsp; Each operation in a separate method. Solve the problem using loops (for and while)
          2.&emsp;Write a program that takes two values as an argument. The first
          &emsp; &emsp;value tells which of the methods of task 1 to execute, the second one 
          &emsp; &emsp; &emsp;tells where to read the list from where the file address should be written 
          &emsp; &emsp; &emsp; &emsp;as an argument. Next, you need to read the array and execute the method.
</pre></p>
<p> 4 Task:<br/><pre>
          1.&emsp;Given an integer array. It is necessary to find the number of emails located after 
            &emsp;the last max
          2.&emsp;Given an integer array. It is necessary to place the elements, located 
           &emsp; &emsp;before the min, at the end of the array
          3.&emsp;An integer array and an interval (a,b) are given. Need to find the max of the elements 
           &emsp; &emsp;in this interval
          4.&emsp;Given an integer array. Output indexes of el-in, which are less than its left  
           &emsp; &emsp;neighbor, and the number of such numbers
          5.&emsp;For the given list + numbers, construct a list of all + prime divisors  
           &emsp; &emsp;of the e-list without repetitions
</pre></p>
</div>
<h3> Kernel classes and models - 2lab</h3>
<div>
<p><h4>1Ex Object and clesses:</h4> <br/><pre>
          1.&emsp;Create the Student class in a separate file with the object fields ID, Last Name, 
            &emsp;First Name, Middle Name, Phone, Telegram, Mail, Git. Full name is required, others are not.
            &emsp;&emsp;Write a constructor, write a getter and a setter for each field, 
            &emsp;&emsp;&emsp;when naming methods it is MANDATORY to use ruby naming conventions.
          2.&emsp;Create several objects from a separate main.rb file and display information about them 
            &emsp;on the screen. Think over the correct way to display information about the current state of 
            &emsp;&emsp;the object on the screen, modify the class.
          3.&emsp;Avoid code duplication in constructor, getter and setter. 
          4.&emsp;Use attributes to concisely write getters and setters. 
          5.&emsp;Provide in the constructor the ability to create objects with any combination of 
            &emsp;&emsp;filling in optional fields.
          6.&emsp;Add a CLASS method that checks if some string is a phone number. Modify the class  
            &emsp;so that at an arbitrary point in time there could not be an object with an invalid 
            &emsp;&emsp;string in the phone number field, for this you will have to modify the constructors.  
            &emsp;&emsp;&emsp;Test the resulting class.
          7.&emsp;Create validations for the correct form of the string in the remaining fields.
          8.&emsp;Write a validate method that performs two validations of the presence of the
            &emsp;&emsp;git and the presence of any contact for communication, if possible separate the methods.
          9.Write a set_contacts method that sets the value of a field or fields for the entered contacts.
          10.&emsp;Start building a class diagram by describing this class.</pre>
</p>
<p><h4>2Ex Reading, view, record entity:</h4> <br/><pre>
          1. Think about the structure of String representation of the class object,coordinate it 
             &emsp;with clause 2. Write a separate constructor accepting a string as an input, 
             &emsp;&emsp;which parses this parses the string and calls the standard constructor with
             &emsp;&emsp;&emsp;arses this string and calls the standard constructor with the parameters. 
             &emsp;&emsp;&emsp;&emsp;Test the constructor from the main class.
          2. Design an exception structure for the given constructor
             &emsp;constructor in case parsing of the string is impossible and in case the data in the 
             &emsp;&emsp;string didn't pass validation. if the data in the string is not validated. 3.
          3. Write a getInfo method that returns brief
             &emsp;information about the student - Surname and Initials; git, communication
             &emsp;&emsp;(specify any means of communication and state what it is) on ONE line. If possible,
             &emsp;&emsp;&emsp;divide the method into components (in the future this information will be displayed in
             &emsp;&emsp;&emsp;&emsp;table and you will have to take it in parts).
          4. Write Student_short class that has 4 ID fields,
             &emsp;Surname and initials, Git, Contact. The fields can't be edit. There are two possible 
             &emsp;&emsp;constructors - one of them is an object of class Student.Student class object, the other
             &emsp;&emsp;&emsp;has an ID and a string that contains and a string that contains all other information.
          5. Refactoring by separating the superclass and removing code duplication in the Student 
             &emsp;and Student_short classes.
          6. Mark the changes in the class diagram.
          7. Write a read_from_txt method that receives file address arguments, throws an exception with
             &emsp;notification if the address is invalid, and returns an array of Student type objects.
          8. Test the method by outputting a brief output of information about each object.
          9. Write a write_to_txt method that receives as address, name of a file, and a list of objects 
             &emsp;of type Student.
          10. Test the compatibility of these methods.
</pre></p>
</div>
