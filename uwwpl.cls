% UWWPL Style file
% derived from Semantics & Pragmatics style file, originally due to:
% Kai von Fintel, Christopher Potts, and Chung-chieh Shan

\NeedsTeXFormat{LaTeX2e}[1994/06/01]
\ProvidesClass{uwwpl}[Class for UWWPL]

% TODO:
% make the title part more elegant

%====================================================================
%===================== release notes ================================

% 2015-01-02: v3.0, include expex option and footnote exx formatting

%======================= Outline ====================================
%====================================================================

% OUTLINE OF THIS CLASS FILE
%   option declarations
%   required packages
%   metadata
%   title
%   frontmatter
%   sectioning
%   footnotes
%   bibliography
%   other environments
%   useful macros

%=====================================================================
%======================== option declarations ========================

% example-numbering packages
\newif\if@expex
\newif\if@linguex
% production settings
\newif\if@biblatex
\newif\if@final

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\newcommand{\@sizeoption@err}{\ClassError{sp}
  {Cannot use size option \CurrentOption}
  {The UWWPL style requires (and automatically loads) 12pt text}}

\DeclareOption{10pt}{\@sizeoption@err}
\DeclareOption{11pt}{\@sizeoption@err}

% example-numbering packages
\DeclareOption{expex}{\@expextrue}
\DeclareOption{linguex}{\@linguextrue}
% production settings
\DeclareOption{biblatex}{\@biblatextrue}
\DeclareOption{final}{\@finaltrue}

\ExecuteOptions{times} % times is the default.
\ProcessOptions\relax
\LoadClass[12pt]{article}

% amsmath must be loaded before unicode-math; might as well load it here
\RequirePackage[leqno,tbtags]{amsmath}

\RequirePackage{ifxetex}


%=====================================================================
%========================= required packages =========================

% times fonts
\RequirePackage{newtxtext,newtxmath}

% geometry package for margins
\RequirePackage[margin=1in, letterpaper]{geometry}

\pagestyle{empty}

\ifxetex
\else
  \RequirePackage[utf8]{inputenc}
  % define U+2011 NON-BREAKING HYPHEN as a regular hyphen + line break prohibition
  % Based on http://tex.stackexchange.com/a/23146
  % plain \mbox{-} doesn't allow the suffix to hyphenate automatically
  \DeclareUnicodeCharacter{2011}{\mbox{-}\nobreak\hskip\z@}
\fi
\RequirePackage{xspace}
% microtype handles punctuation at the right margin. We want it for
% the final product, but it's okay if authors lack it.
\IfFileExists{microtype.sty}{%
  \RequirePackage[final,protrusion={true,compatibility}]{microtype}
}{}
\RequirePackage[hyphens]{url}

% if [biblatex] is requested, check that either the new unified.bbx or the old
% biblatex-sp-unified is available;
% if neither style can be found, fallback to BibTeX.
\if@biblatex
  \IfFileExists{unified.bbx}
    {\RequirePackage[backend=biber,
                    style=unified,
                    natbib,
                    maxcitenames=3,
                    maxbibnames=99]{biblatex}}
    {\IfFileExists{biblatex-sp-unified.bbx}
       {\RequirePackage[backend=biber,
                        bibstyle=biblatex-sp-unified,
                        citestyle=sp-authoryear-comp,
                        natbib,
                        maxcitenames=3,
                        maxbibnames=99]{biblatex}}
       {\ClassWarning{sp.cls}{BibLaTeX requested but cannot find style; falling back to BibTeX}
         \@biblatexfalse}}
\fi

\if@biblatex
\else
  \RequirePackage{natbib}
  \bibpunct[: ]{(}{)}{,}{a}{}{,}
  \newcommand{\BIBand}{\&}
  \setlength{\bibsep}{0pt}
  \setlength{\bibhang}{0.25in}
  \bibliographystyle{sp}
  \newcommand{\posscitet}[1]{\citeauthor{#1}'s (\citeyear{#1})}
  \newcommand{\possciteauthor}[1]{\citeauthor{#1}'s}
  \newcommand{\pgposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~#2)}
  \newcommand{\secposscitet}[2]{\citeauthor{#1}'s (\citeyear{#1}:~$\S$#2)}
  \newcommand{\pgcitealt}[2]{\citealt{#1}:~#2}
  \newcommand{\seccitealt}[2]{\citealt{#1}:~$\S$#2}
  \newcommand{\pgcitep}[2]{(\citealt{#1}:~#2)}
  \newcommand{\seccitep}[2]{(\citealt{#1}:~$\S$#2)}
  \newcommand{\pgcitet}[2]{\citeauthor{#1} (\citeyear{#1}:~#2)}
  \newcommand{\seccitet}[2]{\citeauthor{#1} (\citeyear{#1}:~$\S$#2)}
  % \addbibresource{} and \printbibliography are the names of standard
  % BibLaTeX macros, which are shimmed here to call out to normal BibTeX.
  % The \@bibresources variable stores a list of bibliography arguments,
  % which are subsequently loaded by the 0-arity \printbibliography call.
  \def\@bibresources{}
  % \addbibresource mutably appends the given argument to \@bibresources,
  % maintaining \@bibresources as a comma-separated list of arguments.
  \newcommand{\addbibresource}[1]{%
    % \xdef is like \gdef, but immediately expands the second argument.
    \xdef\@bibresources{\@bibresources\ifx\@empty\@bibresources\else,\fi#1}}
  % \printbibliography simply calls the standard BibTeX \bibliography command
  % with the value of the \@bibresources variable (set earlier, as with BibLaTeX).
  \newcommand{\printbibliography}{\bibliography{\@bibresources}}
\fi

\RequirePackage[usenames,dvipsnames,table]{xcolor}
\definecolor{splinkcolor}{rgb}{.0,.2,.4}
\RequirePackage[colorlinks,breaklinks,
                linkcolor=splinkcolor,
                urlcolor=splinkcolor,
                citecolor=splinkcolor,
                filecolor=splinkcolor,
                plainpages=false,
                pdfpagelabels,
                bookmarks=false,
                pdfstartview=FitH]{hyperref}
\newcommand{\doi}[1]{\url{https://doi.org/#1}}
\urlstyle{rm}
\RequirePackage{graphicx}
\RequirePackage{float}
\RequirePackage[hang,FIGBOTCAP,loose]{subfigure}

%=====================================================================
%============================= metadata ==============================

\def\@pdfauthor{\relax}
\newcommand{\pdfauthor}[1]{\gdef\@pdfauthor{#1}}
\def\@pdftitle{\relax}
\newcommand{\pdftitle}[1]{\gdef\@pdftitle{#1}}
\def\@pdfkeywords{\relax}
\newcommand{\pdfkeywords}[1]{\gdef\@pdfkeywords{#1}}

\hypersetup{pdfauthor=\@pdfauthor,
            pdftitle=\@pdftitle,
            pdfkeywords=\@pdfkeywords}

\def\@spvolume{}
\newcommand{\spvolume}[1]{\gdef\@spvolume{#1}}

\def\@sparticle{}
\newcommand{\sparticle}[1]{\gdef\@sparticle{#1}}

\def\@spyear{}
\newcommand{\spyear}[1]{\gdef\@spyear{#1}}

\def\@spdoi{10.3765/sp.\@spvolume.\@sparticle}

\def\@splastpage{}
\newcommand{\splastpage}[1]{\gdef\@splastpage{#1}}

\def\@copyrightowner{\@shortauthor}
\newcommand{\copyrightowner}[1]{\gdef\@copyrightowner{#1}}


%=====================================================================
%============================== title ================================

% Formats individual <name--institute> pairs inside \author.
\newcommand{\spauthor}[1]{%
  \begin{minipage}[t]{16pc}\centering #1\end{minipage}\hspace{.5pc plus1pc}%
  \ignorespaces
}

\renewcommand*{\title}[2][]{\gdef\@shorttitle{#1}\gdef\@title{#2}}
\renewcommand*{\author}[2][]{\gdef\@shortauthor{#1}\gdef\@author{#2}}

% Adapted from JMLR.
\renewcommand{\maketitle}{%
  \par
  \begingroup
  \renewcommand{\thefootnote}{\fnsymbol{footnote}}
  \@maketitle\@thanks
  \setcounter{footnote}{0}
  \endgroup
  \let\maketitle\relax \let\@maketitle\relax
  \gdef\@thanks{}
  \let\thanks\relax%
}

% From salt.cls.
\newskip\onelineskip
\onelineskip=\baselineskip
\advance\onelineskip by0pt plus 4pt minus 2pt

\def\@maketitle{%
\begin{center}
  {\fontsize{14}{16}\selectfont \bf \@title}

  \vskip\onelineskip
  \@author
\end{center}
}


%=====================================================================
%=========================== frontmatter =============================

\renewenvironment{abstract}%
{\paragraph{Abstract:}}%
{}

\newenvironment{keywords}%
{\paragraph{Keywords:}}%
{}

%=====================================================================
%============================ sectioning =============================

% section header font sizes
\RequirePackage{sectsty}
\sectionfont{\fontsize{12}{15}\selectfont}
\subsectionfont{\fontsize{12}{15}\selectfont \em}
\subsubsectionfont{\fontsize{12}{15}\selectfont \normalfont \em}

% section header spacing (none below headers)
\RequirePackage[noindentafter]{titlesec}
\titlespacing\section{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}
\titlespacing\subsection{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}
\titlespacing\subsubsection{0pt}{12pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}


%=====================================================================
%======================== other environments =========================

% enumerate labeling that won't conflict with standard ex. numbers.
\renewcommand{\theenumi}{\roman{enumi}}
\renewcommand{\labelenumi}{\theenumi.}
\renewcommand{\theenumii}{\alph{enumii}}
\renewcommand{\labelenumii}{\theenumii.}

% list spacing ought to satisfy \itemsep + \parsep < \topsep + \parskip
\def\@listi{\leftmargin\leftmargini
            \parsep 4\p@  \@plus2\p@ \@minus\p@
            \topsep 10\p@ \@plus4\p@ \@minus\p@
            \itemsep4\p@  \@plus2\p@ \@minus\p@}
\let\@listI\@listi
\@listi

%=====================================================================
%=========================== useful macros ===========================

\def\co{\colon\thinspace}

\DeclareRobustCommand\dash{%
  \unskip\nobreak\thinspace\textemdash\thinspace\ignorespaces}
\pdfstringdefDisableCommands{\renewcommand{\dash}{ - }}

% based on \url defined in hyperref.sty
\DeclareRobustCommand*{\http}{\hyper@normalise\http@}
\def\http@#1{\hyper@linkurl{\Hurl{#1}}{http://#1}}

\newcommand{\email}[1]{\href{mailto:#1}{#1}}

\providecommand{\sv}[1]{\ensuremath{\llbracket{#1}\rrbracket}}

%=====================================================================
%=========================== linguex settings ========================

\if@linguex
  \AtEndPreamble{\RequirePackage{linguex}}%
  \AtEndPreamble{\renewcommand{\firstrefdash}{}}%
  \AtBeginDocument{\settowidth{\Exlabelwidth}{(110)}}
\fi

%=====================================================================
%=========================== expex settings ========================

\if@expex
  \RequirePackage{expex}%
  \lingset{%
    exskip=-0.5ex,
    interpartskip=0.5ex,
    aboveexskip=1ex,
    belowexskip=2ex,
    everygla=}
  \def\everyfootnote{%
    \keepexcntlocal
    \excnt=1
    % exskip: sets aboveexskip and belowexskip at the same time
    % exnotype: sets the family for root example numbering (default: arabic)
    %           (must be one of: arabic, chapter.arabic, or roman)
    % sampleexno: sets root example to constant width (default: no constant width)
    % labeltype: sets the family for subexample numbering (default: alpha)
    % labelanchor: sets left alignment of subexample (default: numright)
    % labeloffset: left margin of subexample numbering (default: 1em)
    % textoffset: distance between subexample numbering and text (default: 1em)
    \lingset{exskip=1ex,exnotype=roman,labeloffset=.6em,textoffset=.6em}
  }
  \renewcommand{\@makefntext}[1]{%
    \everyfootnote
    \parindent=0.25in
    \noindent \hbox to \z@{\hss{\@thefnmark} \hfil}#1%
  }
  \gathertags
\fi

%================================ fin ================================
%=====================================================================
