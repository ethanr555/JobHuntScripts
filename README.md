# Job Hunt Tools

Hello, these are some tools I quickly made that helped me with mass job applying. 

## Tools:

- resumegen:
	- This creates a resume from a base LaTeX template. Once that is done, it exports a fresh copy as a PDF, with it named by job name, company, and time and date.
	- Useful if you already have a decent resume in LaTeX ready to go, just need a couple of edits for the specific job (changing description, adding certain keywords, etc.)
- aipromptgen:
	- I realized it was easier to feed the job description to a LLM to return summarized details such as programming languages, logistical skills, frameworks, platforms, etc.
	- What the shell script does is combined the prompt stated in the promptheader.txt with website specific Javascript. It copies the result to your clipboard.
	- Then, you use the inspect element feature of your browser, use the console, and paste that command on the website where the job description is listed. Once execute, the job description with the prompt header is saved to your clipboard
	- Finally, just paste that to the prompt of the LLM you are using to get the results. Utilizing keyboard shortcuts, you can quickly navigate and paste all this to quickly get comma separated lists.
	- These elements could be useful to paste while you edit your resume with the ResumeGen script mentioned above.
	- Websites supported right now are Indeed and LinkedIn.

Ultimately this repository was more so for fun but does help a bit with getting through a bunch of applications.
