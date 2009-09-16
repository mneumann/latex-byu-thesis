% BYU MS/PhD LaTeX Class File
%   (version $Id: byumsphd.cls 4619 2007-03-10 04:03:10Z chris $)
%
% Copyright (c) 2006 Christopher K. Monson
% The latest version of this file may be obtained from
%   http:www.bouncingchairs.net/oss
%
% License: LaTeX Project Public License (www.latex-project.org/lppl.txt)
%   Executive summary:
%       This software is copyright but you are granted a license which gives
%       you, the "user" of the software, legal permission to copy, distribute,
%       and/or modify the software. However, if you modify the software and
%       then distribute it (even just locally) you must change the name of the
%       software to avoid confusion.
%
% OR (dual-licensed)
%
% License: GNU Lesser General Public License (www.gnu.org/licenses/lgpl.html)
%
% Author Information:
%   Christopher K. Monson
%   Brigham Young University
%   monpublic@gmail.com
%
% Please contact the author for change requests.  If you have patches, please
% send those to the author as well so that this class has a single point of
% distribution and all may benefit.
%
% Version: 1.0.11
%
% Changelog:
%   Chris Monson (2009-09-16):
%       *   Bumped version to 1.0.11
%       *   Updated example file to be more informative.
%   Chris Monson (Anonymous Contrib) (2009-03-06):
%       *   Bumped version to 1.0.10
%       *   Added \copyrighttext settable option (replacing All Rights
%           Reserved)
%   Chris Monson (2008-05-21):
%       *   Bumped version to 1.0.9
%   Lloyd Brown (Contrib) (2008-05-15):
%       *   Added option for setting "Department" as in "Accepted for the 
%           Department" to something else
%       *   Added option for setting "Graduate Coordinator" title to something
%           else
%	*   This closes issue 8 in the tracker
%   Chris Monson (2007-07-06):
%       *   Bumped version to 1.0.8
%       *   Fixed signature page to be compliant with new rules
%       *   Added duplexprinter convenience option
%       *   Added tocbibind to the example file to show people how to get their
%           bibliography referenced in the TOC
%       *   This closes issues 4 and 6 in the tracker
%   Chris Monson (2007-03-10):
%       *   Bumped version to 1.0.5
%       *   Addressed issue (2) on code.google.com/p/latex-byu-thesis as follows
%       *   Created a fake pdfbookmark command that switches on with hyperref
%       *   Inserted pdfbookmark commands per Dan Delorey (new requirements)
%       *   Later bumped version to 1.0.6
%       *   Added an option to put an entry for References into the TOC
%       *   Later bumped version to 1.0.7
%       *   Reverted the addition of refintoc.  There is an easier way in the
%           document itself, and it is too dependent on the particular
%           bibliography environment used.
%   Chris Monson (2007-03-09):
%       *   Bumped version to 1.0.4
%       *   Added the LGPL as an alternate license
%   Chris Monson (2007-02-01):
%       *   Created a version number and bumped it to 1.0.3
%       *   Added option for setting "Department of" string to something else
%   Chris Monson (2006-03-13):
%       *   Removed some cruft
%       *   Established some suitable defaults
%   Chris Monson (2006-03-10):
%       *   First reasonable release
%
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{byumsphd}[2007/03/10 BYU LaTeX MS/PhD Class]
%
% Boolean option creation
\newif\if@thesis % generates \if@thesis, \@thesistrue, and \@thesisfalse
\newif\if@chapternum % for putting page numbers on part and chapter pages
\newif\if@centerchapter % for centered chapter headings vs. left-justified
\newif\if@vcenterpart % for vertical centering of parts vs. top
\newif\if@compliantsizes % for headings no larger than 12 pt (ugly)
\newif\if@lof % Show list of figures?
\newif\if@lot % Show list of tables?
\newif\if@needdrawing % Need the eso-pic environment?  Drawing something?
\newif\if@layout % This will draw lines showing all the margins
\newif\if@grid % Show a grid
\newif\if@separator % Show a separator page between the single-sided and double-sided parts of the document
\newif\if@duplexprinter % Ensure that there are an even number of pages in the front matter

\newcommand{\@@sideval}{twoside}
\newcommand{\@@openval}{openright}
\newcommand{\@@ptsize}{12pt}

% This is an empty no-op command in case pdfbookmark is not defined (hyperref
% not included)
\newcommand{\@@pdfbookmark}[3][1]{%
  \ifx\pdfbookmark\undefined
    \relax
  \else
    \pdfbookmark[#1]{#2}{#3}%
  \fi
}%

%
% This document can serve as either a PhD dissertation or a Master's thesis
\DeclareOption{compliantheadings}{\@compliantsizestrue}
\DeclareOption{prettyheadings}{\@compliantsizesfalse}
\DeclareOption{chaptercenter}{\@centerchaptertrue}
\DeclareOption{chapterleft}{\@centerchapterfalse}
\DeclareOption{partmiddle}{\@vcenterparttrue}
\DeclareOption{parttop}{\@vcenterpartfalse}
\DeclareOption{ms}{\@thesistrue}
\DeclareOption{phd}{\@thesisfalse}
\DeclareOption{chapternum}{\@chapternumtrue}
\DeclareOption{nochapternum}{\@chapternumfalse}
\DeclareOption{lof}{\@loftrue}
\DeclareOption{lot}{\@lottrue}
\DeclareOption{layout}{\@needdrawingtrue \@layouttrue}
\DeclareOption{grid}{\@needdrawingtrue \@gridtrue}
\DeclareOption{separator}{\@separatortrue}
\DeclareOption{duplexprinter}{\@duplexprintertrue}
\DeclareOption{twoside}{\renewcommand{\@@sideval}{twoside}}%
\DeclareOption{oneside}{\renewcommand{\@@sideval}{oneside}}%
\DeclareOption{openright}{\renewcommand{\@@openval}{openright}}%
\DeclareOption{openany}{\renewcommand{\@@openval}{openany}}%
\DeclareOption{10pt}{\renewcommand{\@@ptsize}{10pt}}%
\DeclareOption{11pt}{\renewcommand{\@@ptsize}{11pt}}%
\DeclareOption{12pt}{\renewcommand{\@@ptsize}{12pt}}%
% Ignore the letterpaper option, but allow it to be passed.
\DeclareOption{letterpaper}{\typeout{Ignoring option ``letterpaper''}}%

\setlength{\unitlength}{1in}
%
% Default to NOT showing lists of figures and tables
\@loffalse
\@lotfalse
% Default to PhD
\@thesisfalse
% Default to one-sided printing
\@duplexprinterfalse
% Don't show the layout, usually
\@needdrawingfalse
\@layoutfalse
\@gridfalse
\ExecuteOptions{%
    chapternum,
    chapterleft,
    partmiddle,
    prettyheadings,
    }%
\ProcessOptions
%
% We base our work on the report class
%
% You would think that we could just use a DeclareOption* and pass the options
% on to this class, but that doesn't work very well.  If you want to do that,
% you can't use ExecuteOptions to set defaults because then the overriding
% options never get passed.  It's nuts.  So, this is how we do it, with
% appropriate default specifications.
\LoadClass[\@@ptsize,letterpaper,\@@sideval,\@@openval]{report}
%
% Rather than fiddle with spacing, we set it up using the setspace package
% Note that even though most of the document is double spaced, we start with
% single spacing because of the following reasons:
%  * setspace likes to *enlarge* the spacing, not shrink it
%  * the minimum style requirements dictate vertical spacing as a number of
%   ``blank lines'', and the size of those lines is single-spaced.
\RequirePackage[singlespacing]{setspace}
%
% The geometry package is great and we use it rather than fiddling with the
% margins directly.  We do have to employ some margin-fiddling trickery after
% the preamble, however, because the geometry package does not provide a way to
% set the margins in the middle of a document.
%
\RequirePackage[
    top=1.0in,
    bottom=1.0in,
    inner=1.5in,
    outer=1.0in,
    ]%
    {geometry}
%
% If we are showing layout grids, then we include the appropriate package and
% draw stuff on every page.
\if@needdrawing
    \RequirePackage[grid=false]{eso-pic}%
    \newcommand{\@vertline}{\line(0,1){11}}
    \newcommand{\@horzline}{\line(1,0){8.5}}
    \newcommand{\@maingrid}{%
        \multiput(1,0)(1,0){8}{\thicklines\@vertline}%
        \multiput(0,1)(0,1){10}{\thicklines\@horzline}%
    }%
    \newcommand{\@smallgrid}{%
        \multiput(0.5,0)(1,0){8}{\thinlines\@vertline}%
        \multiput(0,0.5)(0,1){11}{\thinlines\@horzline}%
    }%
    \newcommand{\@layoutpreamble}{\setlength{\unitlength}{1in}}
    \newcommand{\@rightsidebox}{
        \put (1.5,1){\dashbox{0.03125}(6,9)}%
    }%
    \newcommand{\@leftsidebox}{
        \put (1,1){\dashbox{0.03125}(6,9)}%
    }%
    \newcommand{\@prefaceinnerbox}{
        \put (1.5,1){\dashbox{0.03125}(6,8)}%
    }%
    \AddToShipoutPicture{%
        \@layoutpreamble
        \if@layout
            \@rightsidebox
            \@leftsidebox
            \@prefaceinnerbox
        \fi
        \if@grid
            \@smallgrid
            \@maingrid
        \fi
    }%
\fi
% Name of the degree
\newcommand*{\@degreename}{%
    \if@thesis%
        Master of Science%
    \else%
        Doctor of Philosophy%
    \fi%
}%
%
% Name of document
\newcommand*{\@documenttype}{%
    \if@thesis%
        thesis%
    \else%
        dissertation%
    \fi%
}%
%
% Page style for initial chapter and part pages
\newcommand*{\@chapterpagestyle}{%
    \if@chapternum%
        \thispagestyle{plain}%
    \else%
        \thispagestyle{empty}%
    \fi%
}%
%
% Tells the chapter headings how to justify themselves (center or left)
\newenvironment{@headjustify}{%
    \begingroup
    \if@centerchapter
        \centering
    \fi
}{%
    \endgroup
}%
%
% Sets the top spacing for a Part
\newcommand{\@parttopspace}{%
    \if@vcenterpart
        \vspace*{\fill}\par
    \else
        \begin{singlespace}%
            \vspace*{\@prefacemargingapsingle}\par
        \end{singlespace}%
    \fi
}%
%
% Sets the bottom spacing for a Part
\newcommand{\@partbottomspace}{%
    \if@vcenterpart
        \vspace*{\fill}\par
    \else
        \begin{singlespace}%
            \vspace*{3\@blankline}\par
        \end{singlespace}%
    \fi
}%
%
% Use this instead of \Large in case compliant sizes are needed
\newcommand{\@sizeLarge}{%
    \if@compliantsizes
        \normalsize
    \else
        \Large
    \fi
}%
%
% Use this instead of \large in case compliant sizes are needed
\newcommand{\@sizelarge}{%
    \if@compliantsizes
        \normalsize
    \else
        \large
    \fi
}%
%
% Use this instead of \Huge in case compliant sizes are needed
\newcommand{\@sizeHuge}{%
    \if@compliantsizes
        \normalsize
    \else
        \Huge
    \fi
}%
%
% Use this instead of \huge in case compliant sizes are needed
\newcommand{\@sizehuge}{%
    \if@compliantsizes
        \normalsize
    \else
        \huge
    \fi
}%
%
\newcommand{\setup@bodymargins}{%
    \if@twoside
        \setlength{\evensidemargin}{0.0in}%
    \else
        \setlength{\evensidemargin}{0.5in}%
    \fi
}%
%
\newcommand{\@clearemptydoublepage}{%
    \clearpage
    {\pagestyle{empty}\cleardoublepage}%
}%
%
\newcommand{\clearpage@forchapter}{%
    \if@openright
        \cleardoublepage
    \else
        \clearpage
    \fi
}%
%
% These are internal variables used throughout the class.  They represent
% default values for their corresponding @-less versions.
\newcommand{\@university}{Brigham Young University}
\newcommand{\@department}{Computer Science}
\newcommand{\@departmentprefix}{Department of}
\newcommand{\@departmentprefixshort}{Department}
\newcommand{\@graduatecoordinator}{Parris~K.~Egbert}
\newcommand{\@graduatecoordinatortitle}{Graduate~Coordinator}
\newcommand{\@college}{College of Physical and Mathematical Sciences}
\newcommand{\@collegedean}{Thomas~W.~Sederberg}
\newcommand{\@collegedeantitle}{Associate Dean}
\newcommand{\@committeechair}{}
\newcommand{\@committeemembera}{}
\newcommand{\@committeememberb}{}
\newcommand{\@committeememberc}{}
\newcommand{\@committeememberd}{}
\newcommand{\@monthsubmitted}{}
\newcommand{\@yearsubmitted}{}
\newcommand{\@yearcopyrighted}{\@yearsubmitted}
\newcommand{\@copyrighttext}{All Rights Reserved}
%
\newcommand{\@documentabstract}{}
\newcommand{\@acknowledgments}{}
%
% This tells us whether to generate the acknowledgments
\newif\if@hasacknowledgments
\@hasacknowledgmentsfalse
%
% Here are some things that can be set from inside the document.  Most of them
% have suitable defaults.
\newcommand{\university}[1]{\renewcommand{\@university}{#1}}
\newcommand{\department}[1]{\renewcommand{\@department}{#1}}
\newcommand{\departmentprefix}[1]{\renewcommand{\@departmentprefix}{#1}}
\newcommand{\departmentprefixshort}[1]{\renewcommand{\@departmentprefixshort}{#1}}
\newcommand{\graduatecoordinator}[1]{\renewcommand{\@graduatecoordinator}{#1}}
\newcommand{\graduatecoordinatortitle}[1]{\renewcommand{\@graduatecoordinatortitle}{#1}}
\newcommand{\college}[1]{\renewcommand{\@college}{#1}}
\newcommand{\collegedean}[1]{\renewcommand{\@collegedean}{#1}}
\newcommand{\collegedeantitle}[1]{\renewcommand{\@collegedeantitle}{#1}}
\newcommand{\committeechair}[1]{\renewcommand{\@committeechair}{#1}}
\newcommand{\committeemembera}[1]{\renewcommand{\@committeemembera}{#1}}
\newcommand{\committeememberb}[1]{\renewcommand{\@committeememberb}{#1}}
\newcommand{\committeememberc}[1]{\renewcommand{\@committeememberc}{#1}}
\newcommand{\committeememberd}[1]{\renewcommand{\@committeememberd}{#1}}
\newcommand{\monthsubmitted}[1]{\renewcommand{\@monthsubmitted}{#1}}
\newcommand{\yearsubmitted}[1]{\renewcommand{\@yearsubmitted}{#1}}
\newcommand{\yearcopyrighted}[1]{\renewcommand{\@yearcopyrighted}{#1}}
\newcommand{\copyrighttext}[1]{\renewcommand{\@copyrighttext}{#1}}
%
\newcommand{\documentabstract}[1]{\renewcommand{\@documentabstract}{#1}}
\newcommand{\acknowledgments}[1]{\@hasacknowledgmentstrue\renewcommand{\@acknowledgments}{#1}}
%
% Internal lengths with no external settings
\newlength{\@assumedcharwidth}
\newlength{\@defaultindent}
\newlength{\@sigskip}
\newlength{\@blankline}
\newlength{\@prefacemargingapsingle}
\newlength{\@prefacemargingapdouble}
\setlength{\@assumedcharwidth}{6pt}
\setlength{\@defaultindent}{6\@assumedcharwidth}
\setlength{\@blankline}{\baselineskip}
\setlength{\@sigskip}{2\@blankline} % signature spacing is 2 blank lines
%
% This is the margin gap between the top of the paper and single-spaced text.  It defines a margin that is a total of 2 inches from the top
\setlength{\@prefacemargingapsingle}{1in}
\setlength{\@prefacemargingapdouble}{\@prefacemargingapsingle}
\addtolength{\@prefacemargingapdouble}{-\baselineskip}
%
% This is defined for a gap that goes from the top of the page down to text
% that is double-spaced.  Because double-spacing text moves the text down
% within a double-space height box, it makes the margins look wrong (even
% though they are technically right).  Subtracting a single-space height fixes
% the problem in these cases.

%\end{doublespace}
%
% Definitions of signature primitives, like the size of the date rule and the
% way that signatures are generally formatted.
\newlength{\Datewidth}
\newlength{\Sigwidth}
\setlength{\Datewidth}{1.5in}
\setlength{\Sigwidth}{3.8in}
%
\providecommand{\Signature}[1]{%
    \noindent
    \parbox[t]{\Datewidth}{%
        \rule{\Datewidth}{0.4pt}\\Date%
    }%
    \hfill
    \parbox[t]{\Sigwidth}{%
        \rule{\Sigwidth}{0.4pt}\\{#1}%
    }%
    \par
}
%
\providecommand{\SignaturePurpose}[2][Accepted]{%
    \noindent
    #1\\ \\%
    \Signature{#2}%
}
%
% Department signature page
\newcommand{\signaturecommitteepage}{%
    \clearpage
    {\parindent 0pt%
    \vspace*{\@prefacemargingapdouble}%
    {\centering
        \MakeUppercase{\@university}%
        \vspace{3\@blankline}\par
        GRADUATE COMMITTEE APPROVAL%
        \vspace{5\@blankline}\par
        \begin{doublespace}%
        of a {\@documenttype} submitted by\\%
        \@author
        \end{doublespace}%
    \par}% end centering
    \vspace{2\@blankline}\par
    This {\@documenttype} has been read by each member of the following
    graduate committee and by majority vote has been found to be
    satisfactory.
    \vspace{3\@blankline}\par
    \Signature{\@committeechair, Chair}%
    \vspace{\@sigskip}\par
    \Signature{\@committeemembera}%
    \vspace{\@sigskip}\par
    \Signature{\@committeememberb}%
    \if@thesis\else
        \vspace{\@sigskip}\par
        \Signature{\@committeememberc}%
        \vspace{\@sigskip}\par
        \Signature{\@committeememberd}%
    \fi
    }% end parindent
    \newpage
}%
%
% University signature page
\newcommand{\signatureuniversitypage}{%
    \clearpage
    {\parindent 0pt%
    \vspace*{\@prefacemargingapdouble}%
    {\centering
        \MakeUppercase{\@university}%
    \par}% end centering
    \vspace{3\@blankline}\par
    As chair of the candidate's graduate committee, I have read
    the {\@documenttype} of {\@author} in its final form and have
    found that (1) its format, citations, and bibliographical
    style are consistent and acceptable and fulfill university and
    department style requirements; (2) its illustrative materials
    including figures, tables, and charts are in place; and (3)
    the final manuscript is satisfactory to the graduate committee
    and is ready for submission to the university library.
    \vspace{4\@blankline}\par
    \Signature{\@committeechair\\Chair, Graduate Committee}%
    \vspace{\fill}\par
    \SignaturePurpose[Accepted for the \@departmentprefixshort]{\@graduatecoordinator\\\@graduatecoordinatortitle}%
    \vspace{\fill}\par
    \SignaturePurpose[Accepted for the College]{\@collegedean\\\@collegedeantitle, \@college}%
    \vspace{\fill}\par
    }% end parindent
    \newpage
}%
%
% Title page
\renewcommand{\titlepage}{%
    \clearpage
    \@@pdfbookmark[1]{Title Page}{title}%
    {\parindent 0pt%
    {\centering
    \vspace*{\@prefacemargingapdouble}%
    \parbox[t]{5in}{\centering
        \begin{doublespace}%
            \MakeUppercase{\@title}%
        \end{doublespace}%
    \par}%
    \vfill
        \begin{doublespace}%
            by\\\@author
        \end{doublespace}%
    \vfill
    \vfill
        \begin{doublespace}%
            A {\@documenttype} submitted to the faculty of\\%
            \@university\\%
            in partial fulfillment of the requirements for the degree of%
        \end{doublespace}%
    \vfill
        \begin{doublespace}%
            \@degreename
        \end{doublespace}%
    \vfill
    \vfill
    \vfill
        \begin{doublespace}%
            {\@departmentprefix} {\@department} \\%
            \@university\\%
            {\@monthsubmitted} {\@yearsubmitted}%
        \end{doublespace}%
    \par}% end centering
    }% end parindent
    \newpage
}%
%
\newcommand{\copyrightpage}{%
    \clearpage
    {\centering
    \parindent 0pt
    \vspace*{\fill}%
    \begin{doublespace}
        Copyright {\copyright} {\@yearcopyrighted} {\@author}\\%
        {\@copyrighttext}%
    \end{doublespace}
    \vspace*{\fill}%
    \par}% end centering
    \newpage
}%
%
\newcommand{\abstractpage}{%
    \clearpage
    \@@pdfbookmark[1]{Abstract}{abstract}%
    {\centering
    \parindent 0pt%
    \vspace*{\@prefacemargingapdouble}%
    ABSTRACT%
    \vspace{3\@blankline}\par
    \parbox[t]{5in}{\centering
        \begin{doublespace}%
            \MakeUppercase{\@title}%
        \end{doublespace}%
    \par}% end parbox
    \vspace{3\@blankline}\par
    \begin{doublespace}%
        {\@author}\\%
        {\@departmentprefix} {\@department}\\%
        \@degreename
    \end{doublespace}%
    \vspace{3\@blankline}\par
    \par}% end centering
    \begin{doublespace}%
        \@documentabstract
    \end{doublespace}%
    \newpage
}%
%
\newcommand{\acknowledgmentspage}{%
    \clearpage
    {\centering
    \parindent 0pt%
    \vspace*{\@prefacemargingapdouble}%
    ACKNOWLEDGMENTS%
    \vspace{4\@blankline}\par
    \par}% end centering
    \begin{doublespace}%
        \@acknowledgments
    \end{doublespace}%
    \newpage
}%
%
\renewcommand{\tableofcontents}{%
    \clearpage
    \@@pdfbookmark[1]{Table of Contents}{toc}%
    \@tocheader{\contentsname}%
    \thispagestyle{plain}%
    \@starttoc{toc}%
    \newpage
}%
%
\renewcommand{\listoffigures}{%
    \clearpage
    \@@pdfbookmark[1]{List of Figures}{lof}%
    \@tocheader{\listfigurename}%
    \@starttoc{lof}%
    \newpage
}%
%
\renewcommand{\listoftables}{%
    \clearpage
    \@@pdfbookmark[1]{List of Tables}{lot}%
    \@tocheader{\listtablename}%
    \@starttoc{lot}%
    \newpage
}%
%
\newcommand{\@separatorpage}{%
    \clearpage
    \thispagestyle{empty}%
    {\centering
    \vspace*{\fill}
    DISCARD THIS PAGE --- IT IS ONLY A MARKER\\
    \vspace{3\@blankline}%
    All preceding pages must be single-sided.\\
    All subsequent pages must be double-sided.
    \vspace*{\fill}
    \par}% end centering
    \newpage
}%
%
% Lifted from report.cls and edited to be smaller
% NOTE that the minimum standards document indicates that ALL fonts should be
% 10, 11, or 12 point *including titles and headings*.  This requirement is
% incredibly ugly, but if you want to comply with it, change everything to
% normalsize in this document.
\renewcommand{\section}{\@startsection {section}{1}{\z@}%
                                   {-3.5ex \@plus -1ex \@minus -.2ex}%
                                   {2.3ex \@plus.2ex}%
                                   {\normalfont\@sizelarge\bfseries}}%
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}%
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                     {-3.25ex\@plus -1ex \@minus -.2ex}%
                                     {1.5ex \@plus .2ex}%
                                     {\normalfont\normalsize\bfseries}}%
%
\renewcommand{\chapter}{%
    \clearpage@forchapter
    \thispagestyle{plain}%
    \@afterindenttrue
    \global\@topnum\z@
    \secdef\@chapter\@schapter
}%
%
\newcommand{\@tocheader}[1]{%
    \begin{@headjustify}%
    \@chapterpagestyle
    \parindent 0pt%
        \begin{singlespace}%
        \vspace*{\@prefacemargingapdouble}%
        \ifnum \c@secnumdepth > \m@ne
            \@sizeLarge \bf {#1}%
            \par
            \vspace{\@blankline}%
        \fi
        \vspace{\@blankline}%
        \end{singlespace}%
        \nobreak
    \end{@headjustify}%
}%
%
\renewcommand{\@makechapterhead}[1]{%
    \begin{@headjustify}%
    \@chapterpagestyle
    \parindent 0pt%
        \begin{singlespace}%
        \vspace*{\@prefacemargingapdouble}%
        \ifnum \c@secnumdepth > \m@ne
            \@sizeLarge \bf \expandafter{\@chapapp{} \thechapter}%
            \par
            \vspace{\@blankline}%
        \fi
        \end{singlespace}%
        \@sizelarge \bf {#1} \par
        \begin{singlespace}%
        \vspace{\@blankline}%
        \end{singlespace}%
        \nobreak
    \end{@headjustify}%
}%
%
\renewcommand{\@makeschapterhead}[1]{%
    \begin{@headjustify}
    \@chapterpagestyle
    \parindent 0pt%
        \begin{singlespace}%
        \vspace*{\@prefacemargingapdouble}%
        \@sizelarge \bf {#1} \par
        \vspace{\@blankline}%
        \end{singlespace}%
        \nobreak
    \end{@headjustify}%
}%
%
\renewcommand{\part}{%
    \clearpage@forchapter
    \@chapterpagestyle
    \@parttopspace
    \secdef\@part\@spart
}%
%
\def\@part[#1]#2{%
    \ifnum \c@secnumdepth >-2\relax
        \refstepcounter{part}%
        \addcontentsline{toc}{part}{\thepart\hspace{1em}#1}%
    \else
        \addcontentsline{toc}{part}{#1}%
    \fi
    \markboth{}{}% empty headings
    {\centering
        \interlinepenalty \@M
        \normalfont
        \ifnum \c@secnumdepth >-2\relax
            \@sizehuge\bfseries \partname\nobreakspace\thepart
            \par
            \vskip 20\p@
        \fi
        \@sizeHuge \bfseries #2%
    \par}% end centering
    \@partbottomspace
}%
%
\def\@spart#1{%
    \addcontentsline{toc}{part}{#1}%
    \@chapterpagestyle
    {\centering
        \interlinepenalty \@M
        \normalfont
        \@sizeHuge \bfseries #1%
    \par}% end centering
    \@partbottomspace
}%
%
\let\old@bibliography\bibliography
\renewcommand{\bibliography}[1]{%
    \onehalfspace\par
    \old@bibliography{#1}%
}%
%
\renewcommand{\maketitle}{%
    \begin{singlespace}%
    \pagenumbering{roman}%
    {%
        \pagestyle{empty}%
        \setlength{\evensidemargin}{0.5in}%
        \titlepage
        \copyrightpage
        \signaturecommitteepage
        \signatureuniversitypage
        \abstractpage
        \if@hasacknowledgments
            \acknowledgmentspage
        \fi
        \begin{doublespace}%
            \pagestyle{plain}%
            \tableofcontents
            \if@lof
                \listoffigures
            \fi
            \if@lot
                \listoftables
            \fi
        \if@twoside
            \if@separator
                \@separatorpage
            \fi
        \fi
        \end{doublespace}%
    }%
    \end{singlespace}%
    \if@duplexprinter
        \@clearemptydoublepage
    \fi
    % Body starts here
    \setup@bodymargins
    % It is vital that we switch numbering BEFORE clearing to start a new page,
    % since clearing it before numbering is switched may produce an erroneous
    % blank page.  This way that page never gets created.
    \pagenumbering{arabic}%
    \clearpage@forchapter
}%
%
% Fix the abstract environment for individual chapters
\renewenvironment{abstract}%
{%
    \begin{singlespace}%
    {\vspace*{\fill}\centering\bf\@sizelarge Abstract\bigskip\par}%
    \end{singlespace}%
    \begingroup\noindent
}%
{%
    \endgroup\vspace*{\fill}%
}%
%
%
% Set up default document settings
\AtBeginDocument{%
    \pagestyle{plain}%
    \pagenumbering{arabic}%
    \setup@bodymargins
    \parindent \@defaultindent
    % Set up double spacing---this is safe because the overall document is
    % single-spaced and we'll set up single spacing as the default in maketitle
    % where spacing matters.
    \doublespace
}%
%
% vim: ft=tex
