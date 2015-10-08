# Introduction #

As is true with any large semi-bureaucratic organization, including a university such as BYU, requirements change, and sometimes not for the better.  Some of these changes can be handled by fixing the class file, and I do that whenever it is possible.  Some, however, need specific hacks placed into the document itself, and this section addresses those.  Each gets its own little section.

# Bibliography entry in the Table of Contents with appropriate bookmarks #

This is a problem for those using electronic submission.  The dissertation/thesis must have an entry in the table of contents called "References" that properly links to the citations.  This is ugly, non-standard, and has kept me awake for a few nights, which is why I have grumpy words about it.  The problem lies with the fact that bibliographic style files are very different beasts from documents, and usually lead separate lives.

This gets an order of magnitude worse when paper dissertations are involved and students discover that they can do something magical by including "chapterbib" in their document.  This allows them to keep their papers looking like papers, with specific reference sections at the end of each one.

This section addresses this requirement as best it can, using a mixture of hackery, advice, and some ideas for making things easier in the future.

## Avoid "chapterbib" Like You Would Avoid Unchastity ##

This literally promiscuous package has to resort to some severe monkey-patching in order to work at all.  This makes it a very brittle package to use, with unpredictable results.  When I wrote my own paper-format dissertation, I did a lot of research into chapterbib and came to the solid conclusion that I should avoid it.  You probably should, too.  Your paper-format dissertation can have one large references section at the end.  It looks fine, and when you see it in action it actually makes a lot more sense than having a separate references section in each paper.

Not using chapterbib makes a lot of things a great deal easier.  It's like magic!

## Use "natbib" With a Tiny Hack ##

If you aren't using the excellent "natbib" package, you should.  It is amazingly flexible, and can easily handle a large number of sometimes bizarre requirements (in other words, it might handle those of your university).

If you are using natbib, you can put these three lines of TeX/LaTeX just before your \bibliography command:

```
\renewcommand{\bibname}{References}
\let\oldbibsection\bibsection
\renewcommand{\bibsection}{\oldbibsection\addcontentsline{toc}{part}{References}}
```

This does two things: it changes the name of your bibliography section to "References" (that part is optional, and a matter of taste), and it alters natbib's section header to include a command to create a line in your table of contents for the references.  This also does appropriate bookmarking in PDF documents, which is apparently a really sticky issue lately.

## Rename bibitems ##
If you have a hard-coded thebibliography section in your intro to list publications, make sure to rename the bibitems to ones different than those you may cite in later chapters. This prevents collisions with your bibtex file.

## Ideas For Greater Ease and Transparency ##

The chapterbib comment always applies.  Just don't use it.  The hack above, however, smells funny to me and doesn't make me very happy.  It works, but it's icky on many different levels.

So, there are a couple of strategies that I am considering employing to make this all work much better.

  * Create my own version of natbib.sty and include it in the distribution.  This would allow me to do the appropriate hackery on the file, but it still gives me a funny feeling.
  * Learn more about natbib and see if there is already a way of doing what we want to do.  I have my doubts, frankly, but you never know.
  * Create a brand new bibliography file and tie it into the class file so that everthing is still self-contained.

None of these strikes me as being particularly easy nor clean, so I'm going to look into all of them and see if I can gain some inspiration from the research endeavor.  Suggestions and comments are welcome, and you can always file a bug against this project. It is very actively maintained (particularly when someone is trying to get their document passed off while they run out the door to their first real job).