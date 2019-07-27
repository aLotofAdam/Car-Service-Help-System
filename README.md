# Car-Service-Help-System
Knowledge-based help system designed to deduce possible causes for a car breaking down.

## Tech Stack Used:
Prolog was used to make this program. It was tested using the SWI-Prolog interpreter. A modified version of Bratko's forward-chaining rule interpreter and Bayesian network interpreter is used. 

## About This Project:
This is a simple knowledge-based help system I made for my final project in my AI class. This help system's purpose is to deduce possible causes as to why a car breaks down or stops working. The user is prompted with questions about their car beforehand in order to diagnose the problem. The diagnosis will cover if the engine needs a tune-up, if they need a new motor, if they need a battery replacement, or if the oil needs changing.

![Figure 1](/images/BN.png)
<br/>
**Figure 1:** Design of Bayesian Network<br/>
<br/>
The system has two parts:
* In Part I: the system asks questions to help it diagnose the problem. Then it tells the user the probability of each problem and the most likely problem.
* In Part II: the system asks the user for some information it needs for making a plan. Then it uses forward-chaining rules to recommend a sequence of actions to fix the problem.

## How to Use:
### Note:
This program was tested using the SWI Prolog interpreter, if you are using a different Prolog interpreter you may need to rename the .pl file extensions appropriately.<br/>

### Step 1:
Download the files: carServiceHelpSystem.pl, fig15_11_mod.pl, and fig15_7_mod_1.6.17.pl

### Step 2:
Start your Prolog interpreter (I used SWI-Prolog). 

### Step 3:
Before running the program, tell Prolog to consult fig15_11_mod.pl and fig15_7_mod_1.6.17.pl.<br/>
(in SWI-Prolog, you would use menu commands: Filemenu -> Consult -> ... ).<br/>

### Step 4:
Run the carServiceHelpSystem.pl file and proceed to answer the prompts with "y." for yes and "n." for no.

### Note:
If you run the forward-chaining rules more than once, retract the facts, or just QUIT prolog and start over to flush the facts from memory. 

## Screenshots:
The following screenshots show examples of the help system's prompts and output.<br/>
<br/>
![Figure 2](/images/nnnny.png)
<br/>
<br/>
![Figure 3](/images/nyyyy.png)
<br/>
<br/>
![Figure 4](/images/yyyny.png)
