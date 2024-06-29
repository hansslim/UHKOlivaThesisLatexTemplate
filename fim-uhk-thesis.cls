% ----------------------------------------------------------------------------
% FIM UHK thesis
% ----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{fim-uhk-thesis}[2023/11/17 Šablona pro BP/DP/DIS]

% Výchozí hodnoty parametrů / Default values for parameters
\newif\ifczech \let\ifczech\iftrue
\newif\ifslovak \let\ifslovak\iffalse
\newif\ifenslovak \let\ifenslovak\iffalse
\newif\ifenglish \let\ifenglish\iffalse
\newif\ifczechslovak \let\ifczechslovak\iftrue

\newif\ifzadani   \let\ifzadani\iffalse
\newif\iftwoside   \let\iftwoside\iffalse
\newif\ifoneside   \let\ifoneside\iftrue

%-----------------------------------------------------------------------------
% Parametry třídy
% Class parameters
%-----------------------------------------------------------------------------
\DeclareOption{english}{\let\ifenglish\iftrue\let\ifczech\iffalse\let\ifczechslovak\iffalse}
\DeclareOption{slovak}{\let\ifslovak\iftrue\let\ifczech\iffalse}
\DeclareOption{enslovak}{\let\ifenslovak\iftrue}
\DeclareOption{print}{\let\ifWis\iffalse \let\ifPrint\iftrue}
\DeclareOption{zadani}{\let\ifzadani\iftrue}
\DeclareOption{twoside}{\let\ifoneside\iffalse \let\iftwoside\iftrue}

\DeclareOption*{}
\ProcessOptions\relax
\iftwoside
    \LoadClass[a4paper,twoside,onecolumn,12pt]{article}
\fi
\ifoneside
    \LoadClass[a4paper,oneside,onecolumn,12pt]{article}
\fi

%-----------------------------------------------------------------------------
% Balíčky / Packages
%-----------------------------------------------------------------------------
\ifenglish
  \PassOptionsToPackage{main=english}{babel}
\fi
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage[main=czech,english,slovak]{babel}
\usepackage[utf8]{inputenc}
\usepackage{csquotes}

% BibLaTeX support
\usepackage[backend=biber,style=iso-numeric,url=false,noenddot=false]{biblatex}
\defbibheading{bibliography}[\refname]{\section{Seznam použité literatury}} % TODO: more languages support
% hranaté závorky u citací
\DeclareFieldFormat{labelnumberwidth}{\mkbibbrackets{#1}}
\renewcommand*{\finentrypunct}{}

% vložení [b.d.]. (bez data) v případě year={nodate}
% TODO: podpora více jazyků
\DeclareSourcemap{
  \maps[datatype=bibtex]{
    \map[overwrite=true]{
      \step[fieldsource=year, match=nodate, final]
      \step[fieldset=year, fieldvalue={[b.d.].}]
    }
  }
}

% nastavení citace pro typ závěrečných prací (@thesis) dle ISO 690:2022
% TODO: dodělat podporu dalších jazyků 
\DeclareFieldFormat{urldate}{\mkbibbrackets{cit.\space#1}}

\DeclareBibliographyDriver{thesis}{%
  \usebibmacro{bibindex}%
  \usebibmacro{begentry}%
  \usebibmacro{names:primary}%
  \setunit{\printdelim{nametitledelim}}\newblock
  \usebibmacro{titles}{}{emph}%
  \iffieldundef{url}{}{%
    \printtext{[online]}
  }%
  \setunit{\addspace}%
  \newunit\newblock
  \printfield{type}%
  \newunit\newblock
  \usebibmacro{thesissupervisor}%
  \newunit\newblock
  \printlist{location}\printtext{:}
  \printlist{institution}\printtext{,}
  \printfield{year}
  \newunit\newblock
  \iffieldundef{url}{}{%
    \printfield{url}
  }%
  \newunit\newblock
  \printurldate\printtext{.}
  \usebibmacro{finentry}
}

\usepackage{cmap}
\usepackage[T1]{fontenc}
\usepackage[]{opensans}
\usepackage{ragged2e}
\usepackage{color}
\usepackage{etoolbox}
\usepackage{enumitem}
\usepackage{pdfpages}
\addto\captionsczech{\renewcommand{\refname}{Seznam použité literatury}}
\addto\captionsslovak{\renewcommand{\refname}{Literatúra}}
\usepackage[numbib,nottoc,notlof,notlot]{tocbibind}
\usepackage{titlesec}
\newcommand{\sectionbreak}{\clearpage}
\usepackage{caption}
\captionsetup{labelfont=bf,textfont=bf,justification=raggedright,singlelinecheck=false}
\usepackage{float}
\usepackage{calc}
\usepackage{longtable,booktabs}
\usepackage{xcolor,colortbl}
\usepackage{multirow}
\usepackage{tabularx}
\usepackage{graphicx}
\usepackage{graphics}
\usepackage{epsfig}
\usepackage{acro}
\usepackage{url}
\DeclareUrlCommand\url{\def\UrlLeft{<}\def\UrlRight{>} \urlstyle{tt}}
\def\UrlBreaks{\do\/\do-}
\usepackage{blindtext}
\usepackage{listings}
\usepackage[toc,page,header]{appendix}
\usepackage{fancyhdr}
\RequirePackage{titletoc}
\ifczech
  \usepackage{ae}
\fi

\ifczech
  \main@language{czech}
\else
  \ifslovak
    \main@language{slovak}
  \else
    \main@language{english}
  \fi
\fi

\newtoggle{slovak_used}
\togglefalse{slovak_used}

\ifslovak
  \toggletrue{slovak_used}
\fi

\newtoggle{english_used}
\togglefalse{english_used}

\ifenglish
  \toggletrue{english_used}
\fi

\newtoggle{enslovak_used}
\togglefalse{enslovak_used}

\ifenslovak
  \toggletrue{enslovak_used}
\fi

\newtoggle{czech_used}
\togglefalse{czech_used}

\ifczech
  \toggletrue{czech_used}
\fi

\newtoggle{czechslovak}
\togglefalse{czechslovak}
\ifczech
  \toggletrue{czechslovak}
\fi
\ifslovak
  \toggletrue{czechslovak}
\fi

\newtoggle{zadaniTwop}
\togglefalse{zadaniTwop}
\iftwoside
  \toggletrue{zadaniTwop}
\fi
\iftoggle{zadaniTwop}{
  \ifzadani
    \toggletrue{zadaniTwop}
  \else
    \togglefalse{zadaniTwop}
  \fi
}{}

%-----------------------------------------------------------------------------
% Sazební obrazec a základní formát / Page layout and format
%-----------------------------------------------------------------------------
\usepackage[a4paper, left=3.5cm, right=2cm, top=2cm, bottom=2cm]{geometry}

\linespread{1.3}
\setlength\parindent{0pt}
\setlength{\parskip}{6pt}

% nadpisy / headings
\titleformat{\section}{
\fontfamily{qhv}\fontsize{16pt}{20pt}\selectfont\bfseries}{\thesection 
}{16pt}{}

\titleformat{\subsection}{
\fontfamily{qhv}\fontsize{15pt}{18pt}\selectfont\bfseries\itshape
}{\thesubsection }{16pt}{}

\titleformat{\subsubsection}{
\fontfamily{qhv}\fontsize{14pt}{16pt}\selectfont\bfseries
}{\thesubsubsection }{16pt}{}

\titleformat{\paragraph}[hang]{
\fontfamily{qhv}\fontsize{13pt}{14pt}\selectfont\bfseries\itshape
}{\theparagraph}{16pt}{}

% Nastavení číslování nadpisů 4. úrovně (\paragraph)
\setcounter{secnumdepth}{4}


%-----------------------------------------------------------------------------
% Texty / Texts
%-----------------------------------------------------------------------------
\def\@uhk@CS{Univerzita Hradec~Králové}
\def\@uhk@SK{Univerzita Hradec~Králové}
\def\@uhk@EN{University of Hradec~Králové}
\def\@author@CS{Autor}
\def\@author@SK{Autor}
\def\@author@EN{Author}
\def\@authorfield@CS{Studijní obor}
\def\@authorfield@SK{Študijný odbor}
\def\@authorfield@EN{Field of study}
\def\@annotation@CS{Abstrakt}
\def\@annotation@SK{Abstrakt}
\def\@annotation@EN{Abstract}
\def\@keywords@CS{Klíčová slova}
\def\@keywords@SK{Kľúčové slová}
\def\@keywords@EN{Keywords}
\def\@cite@CS{Citace}
\def\@cite@SK{Citácia}
\def\@cite@EN{Reference}
\def\@tdecl@CS{Prohlášení}
\def\@tdecl@SK{Prehlásenie}
\def\@tdecl@EN{Declaration}
\def\@tackn@CS{Poděkování}
\def\@tackn@SK{Poďakovanie}
\def\@tackn@EN{Acknowledgements}
\def\@titletitle@EN{Title}

\newif\ifnasel
\def\ifEqString#1#2#3#4{\def\testa{#1}\def\testb{#2}%
  \ifx\testa\testb \def#4{#3} \naseltrue \fi%
}

% Výběr typu projektu / project type selection
\newcommand{\set@project}[1]{%
 \naselfalse
 \ifEqString{#1}{BP}{Bakalářská práce}{\@projecttype@CS}%
\ifEqString{#1}{BP}{Bakalárska práca}{\@projecttype@SK}%
%  \ifEqString{#1}{BP}{Bakalářská práce}{\@projecttype@SK}%
 \ifEqString{#1}{BP}{Bachelor's thesis}{\@projecttype@EN}%
 \ifEqString{#1}{BP}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{BP}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{BP}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{BP}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{SP}{Semestrální projekt}{\@projecttype@CS}%
\ifEqString{#1}{SP}{Semestrálny projekt}{\@projecttype@SK}%
%  \ifEqString{#1}{SP}{Semestrální projekt}{\@projecttype@SK}%
 \ifEqString{#1}{SP}{Term project}{\@projecttype@EN}%
 \ifEqString{#1}{SP}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{SP}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{BP}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{SP}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DP}{Diplomová práce}{\@projecttype@CS}%
\ifEqString{#1}{DP}{Diplomová práca}{\@projecttype@SK}%
%  \ifEqString{#1}{DP}{Diplomová práce}{\@projecttype@SK}%
 \ifEqString{#1}{DP}{Master's thesis}{\@projecttype@EN}%
 \ifEqString{#1}{DP}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{DP}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{DP}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{DP}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DR}{Disertační práce}{\@projecttype@CS}%
\ifEqString{#1}{DR}{Dizertačná práca}{\@projecttype@SK}%
%  \ifEqString{#1}{DR}{Disertační práce}{\@projecttype@SK}%
 \ifEqString{#1}{DR}{PhD thesis}{\@projecttype@EN}%
 \ifEqString{#1}{DR}{Školitel}{\@supervisor@CS}%
\ifEqString{#1}{DR}{Školiteľ}{\@supervisor@SK}%
%  \ifEqString{#1}{DR}{Školitel}{\@supervisor@SK}%
 \ifEqString{#1}{DR}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DA}{Teze disertační práce}{\@projecttype@CS}%
\ifEqString{#1}{DA}{Tézy dizertačnej práce}{\@projecttype@SK}%
%  \ifEqString{#1}{DA}{Teze disertační práce}{\@projecttype@SK}%
 \ifEqString{#1}{DA}{PhD thesis summary}{\@projecttype@EN}%
 \ifEqString{#1}{DA}{Školitel}{\@supervisor@CS}%
\ifEqString{#1}{DA}{Školiteľ}{\@supervisor@SK}%
%  \ifEqString{#1}{DA}{Školitel}{\@supervisor@SK}%
 \ifEqString{#1}{DA}{Supervisor}{\@supervisor@EN}%
 \ifEqString{#1}{DT}{Pojednání k tématu disertační práce}{\@projecttype@CS}%
% \ifEqString{#1}{DT}{Teze disertační práce}{\@projecttype@CS}%
\ifEqString{#1}{DT}{Pojednanie k téme dizertačnej práce}{\@projecttype@SK}%
%  \ifEqString{#1}{DT}{Pojednání k tématu disertační práce}{\@projecttype@SK}%
 \ifEqString{#1}{DT}{PhD thesis proposal}{\@projecttype@EN}%
 \ifEqString{#1}{DT}{Školitel}{\@supervisor@CS}%
\ifEqString{#1}{DT}{Školiteľ}{\@supervisor@SK}%
%  \ifEqString{#1}{DT}{Školitel}{\@supervisor@SK}%
 \ifEqString{#1}{DT}{Supervisor}{\@supervisor@EN}%
  \ifEqString{#1}{DEF}{Bakalářská/Diplomová práce}{\@projecttype@CS}%
\ifEqString{#1}{DEF}{Bakalárska/Diplomová práca}{\@projecttype@SK}%
%  \ifEqString{#1}{DEF}{Bakalářská/Diplomová práce}{\@projecttype@SK}%
 \ifEqString{#1}{DEF}{Bachelor's/Master's thesis}{\@projecttype@EN}%
 \ifEqString{#1}{DEF}{Vedoucí práce}{\@supervisor@CS}%
\ifEqString{#1}{DEF}{Vedúci práce}{\@supervisor@SK}%
%  \ifEqString{#1}{DEF}{Vedoucí práce}{\@supervisor@SK}%
 \ifEqString{#1}{DEF}{Supervisor}{\@supervisor@EN}%
 \ifnasel
 \else
   \typeout{Spatny typ projektu! Moznosti: BP, SP, DP, DR, DT, DA}\set@project{DEF}
 \fi
}

% Výběr fakulty / faculty selection
\newcommand{\set@faculty}[3]{%
 \naselfalse
 \ifEqString{#1}{FIM}{Fakulta informatiky a managementu}{\@fim@CS}%
 \ifEqString{#1}{FIM}{Fakulta informatiky a managementu}{\@fim@SK}%
 \ifEqString{#1}{FIM}{Faculty of Informatics and Management}{\@fim@EN}%
 \ifEqString{#1}{DEF}{#2}{\@fim@CS}%
 \ifEqString{#1}{DEF}{#2}{\@fim@SK}%
 \ifEqString{#1}{DEF}{#3}{\@fim@EN}%
 \ifnasel
 \else
   \typeout{Spatna fakulta! Moznosti: FIM}\set@faculty{FIM}
 \fi
}

% Výběr katedry / department selection
\newcommand{\set@department}[3]{%
 \naselfalse
 \ifEqString{#1}{KAL}{Katedra aplikované lingvistiky}{\@department@CS}
 \ifEqString{#1}{KAL}{Katedra aplikované lingvistiky}{\@department@SK}
 \ifEqString{#1}{KAL}{Department of Applied Linguistics}{\@department@EN}
  \ifEqString{#1}{KE}{Katedra ekonomie}{\@department@CS}
 \ifEqString{#1}{KE}{Katedra ekonomie}{\@department@SK}
 \ifEqString{#1}{KE}{Department of Economics}{\@department@EN}
  \ifEqString{#1}{KIT}{Katedra informačních technologií}{\@department@CS}
 \ifEqString{#1}{KIT}{Katedra informačních technologií}{\@department@SK}
 \ifEqString{#1}{KIT}{Department of Information Technologies}{\@department@EN}
  \ifEqString{#1}{KIKM}{Katedra informatiky a kvantitativních metod}{\@department@CS}
 \ifEqString{#1}{KIKM}{Katedra informatiky a kvantitativních metod}{\@department@SK}
 \ifEqString{#1}{KIKM}{Department of Informatics and Quantitative Methods}{\@department@EN}
  \ifEqString{#1}{KM}{Katedra managementu}{\@department@CS}
 \ifEqString{#1}{KM}{Katedra managementu}{\@department@SK}
 \ifEqString{#1}{KM}{Department of Management}{\@department@EN}
  \ifEqString{#1}{KRCR}{Katedra rekreologie a cestovního ruchu}{\@department@CS}
 \ifEqString{#1}{KRCR}{Katedra rekreologie a cestovního ruchu}{\@department@SK}
 \ifEqString{#1}{KRCR}{Department of Recreology and Tourism}{\@department@EN}
 \ifEqString{#1}{DEF}{Název katedry}{\@department@CS}
 \ifEqString{#1}{DEF}{Název katedry}{\@department@SK}
 \ifEqString{#1}{DEF}{Department}{\@department@EN}
 \ifnasel
 \else
   \typeout{Spatna katedra! Moznosti: KAL, KE, KIT, KIKM, KM, KRCR}\set@department{DEF}
 \fi
}

% Název katedry (CS, SK, EN) / name of the department
\def\@departmentname@CS{\@department@CS}
\def\@departmentname@SK{\@department@SK}
\def\@departmentname@EN{\@department@EN}

% Název práce (v jazyce práce) / thesis title (in the language of the thesis)
\iftoggle{slovak_used}{
  \def\@title{\@title@CS}
}{
  \def\@title{\ifczech\@title@CS\else\@title@EN\fi}
}

% Jméno, příjmení, tituly autora / name surname and the titles of the author
\def\get@author{\ifx\undefined\@author@tp\else%
\@author@tp~\fi\@author\ifx\undefined\@author@ta\else,~\@author@ta\fi}
\def\getlc@author{\ifx\undefined\@author@tp\else%
\@author@tp~\fi\@author\ifx\undefined\@author@ta\else,~\@author@ta\fi}
% Jméno, příjmení, tituly vedoucího / name surname and the titles of the supervisor
\def\get@supervisor{\ifx\empty\@supervisor@tp\else%
\@supervisor@tp~\fi\@supervisor\ifx\empty\@supervisor@ta\else,~\@supervisor@ta\fi}

%-----------------------------------------------------------------------------
% Projectinfo - parametrizace šablony / template parameters
%-----------------------------------------------------------------------------
%Parametry 
\define@key{projinfo}{title.cs}{\global\def\@title@CS{#1}}
\define@key{projinfo}{title.en}{\global\def\@title@EN{#1}}
\define@key{projinfo}{subtitle}{\def\@subtitle{#1}}
\define@key{projinfo}{faculty.cs}{\def\@faculty@CS{#1}}
\define@key{projinfo}{faculty.en}{\def\@faculty@EN{#1}}
\define@key{projinfo}{faculty}{\set@faculty{#1}{\@faculty@CS}{\@faculty@EN}}
\define@key{projinfo}{department.cs}{\def\@department@CS{#1}}
\define@key{projinfo}{department.en}{\def\@department@EN{#1}}
\define@key{projinfo}{department}{\set@department{#1}{\@department@CS}{\@department@EN}}
\define@key{projinfo}{project}{\set@project{#1}}
\define@key{projinfo}{year}{\def\@year{#1}}
\define@key{projinfo}{date}{\def\@date{#1}}
%\define@key{projinfo}{author}{\def\@author{#1}}
\define@key{projinfo}{author.name}{\def\@author@n{#1}}
\define@key{projinfo}{author.surname}{\def\@author@s{#1}}
\define@key{projinfo}{author.field}{\def\@author@field{#1}}
\define@key{projinfo}{author.title.a}{\def\@author@ta{#1}}
\define@key{projinfo}{author.title.p}{\def\@author@tp{#1}}
\define@key{projinfo}{supervisor.name}{\def\@supervisor@n{#1}}
\define@key{projinfo}{supervisor.surname}{\def\@supervisor@s{#1}}
\define@key{projinfo}{supervisor.title.a}{\def\@supervisor@ta{#1}}
\define@key{projinfo}{supervisor.title.p}{\def\@supervisor@tp{#1}}
\define@key{projinfo}{keywords.cs}{\def\@tkeywords@CS{#1}}
\define@key{projinfo}{keywords.en}{\def\@tkeywords@EN{#1}}
\define@key{projinfo}{annotation.cs}{\def\@tannotation@CS{#1}}
\define@key{projinfo}{annotation.en}{\def\@tannotation@EN{#1}}
\define@key{projinfo}{declaration}{\def\@declaration{#1}}
\define@key{projinfo}{acknowledgment}{\def\@acknowledgment{#1}}
\define@key{projinfo}{title.length}{\def\@titlelen{#1}}
\define@key{projinfo}{sectitle.length}{\def\@sectitlelen{#1}}

% Výchozí hodnoty / Default values
\setkeys{projinfo}{
  title.cs=Název bakalářské/diplomové práce,
  title.en=Thesis title, 
  subtitle=,
  project=DEF, 
  department=DEF, 
  declaration=, 
  annotation.cs=, 
  annotation.en=, 
  keywords.cs=, 
  keywords.en=,
  author.name=Jméno, 
  author.surname=Příjmení, 
  author.field=, 
  supervisor.name=Jméno,
  supervisor.surname=Příjmení, 
  department.cs=,
  department.en=,
  faculty.cs=,
  faculty.en=,
  faculty=FIM
}

\def\projectinfo{\setkeys{projinfo}}

\def\@author{\@author@n\ \@author@s}
\def\@supervisor{\@supervisor@n\ \@supervisor@s}

% Prohlášení / Declaration
\newcommand{\declaration}[1]{\def\@declaration{#1}}

% Poděkování / Acknowledgement
\newcommand{\acknowledgment}[1]{\def\@acknowledgment{#1}}

% Anotace / annotation
\newcommand{\annotation}[2][cs]{%
 \ifEqString{#1}{cs}{#2}{\@tannotation@CS}%
 \ifEqString{#1}{sk}{#2}{\@tannotation@SK}%
 \ifEqString{#1}{en}{#2}{\@tannotation@EN}%
}

% Klíčová slova / Keywords
\newcommand{\keywords}[2][cs]{%
 \ifEqString{#1}{cs}{#2}{\@tkeywords@CS}%
 \ifEqString{#1}{sk}{#2}{\@tkeywords@SK}%
 \ifEqString{#1}{en}{#2}{\@tkeywords@EN}%
}

\def\setfontsize#1{\fontsize{#1}{\baselineskip}\selectfont}

%-----------------------------------------------------------------------------
% Anotace, klíčová slova \makeannotation
% annotation, keywords \makeannotation
%-----------------------------------------------------------------------------
\newcommand\makeannotation{%
\thispagestyle{empty}

\ifczech
	{\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@CS} 

	\@tannotation@CS
\else
  \ifslovak
    {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@SK} 

	\@tannotation@SK
  \else
    {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@EN} 

	\@tannotation@EN
  \fi
\fi
\\

\ifczech
\noindent\@keywords@CS : \@tkeywords@CS
\else
  \ifslovak
    \noindent\@keywords@SK : \@tkeywords@SK
  \else
    \noindent\@keywords@EN : \@tkeywords@EN
  \fi
\fi

\vspace{2cm}

\iftoggle{czech_used}{
    {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@EN}
    
    \vspace{5mm}
        {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@titletitle@EN: \@title@EN}
    \vspace{5mm}
    
    \noindent\@tannotation@EN
}{
  \ifslovak
    {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@EN}
    
        {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@title@EN}
        \mbox{}
        
    \noindent\@tannotation@EN
  \else
    \ifenslovak
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@SK}
      
        {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@title@EN}
        \mbox{}
        
      \noindent\@tannotation@CS
    \else
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@annotation@CS}
      
        {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@title@EN}
        \mbox{}
        
      \noindent\@tannotation@CS
    \fi
  \fi
}
\\

\iftoggle{czech_used}{
 \noindent\@keywords@EN : \@tkeywords@EN
 }{
   \ifslovak
     \noindent\@keywords@EN : \@tkeywords@EN
   \else
     \ifenslovak
       \noindent\@keywords@SK : \@tkeywords@SK
     \else
       \noindent\@keywords@CS : \@tkeywords@CS
     \fi
   \fi
 }

\newpage
}

%-----------------------------------------------------------------------------
% Prohlášení, poděkování \makedeclaration
% Declaration, acknowledgement \makedeclaration
%-----------------------------------------------------------------------------
\newcommand\makedeclaration{
\thispagestyle{empty}%

\mbox{}
\vfill

\ifslovak
  {\bfseries \@tdecl@SK :}
\else
  {\bfseries \ifczech\@tdecl@CS :\else\@tdecl@EN :\fi}
\fi

\noindent\@declaration

\vspace{2cm}
  
\noindent V Hradci Králové dne \@date \hfill \@author

\newpage
\thispagestyle{empty}%

\mbox{}
\vfill

\ifx\undefined\@acknowledgment
\else
\vspace{20mm}
\ifslovak
  {\bfseries \@tackn@SK :}
\else
  {\bfseries \ifczech\@tackn@CS :\else\@tackn@EN :\fi}
\fi

\noindent\@acknowledgment
\fi

\newpage
}

%-----------------------------------------------------------------------------
% Úvodní stránky \maketitle
% Introductory pages \maketitle
%-----------------------------------------------------------------------------
\renewcommand\maketitle{
\thispagestyle{empty}
\begin{center}
    \ifczech
      {\bfseries \@uhk@CS \\* \@fim@CS \\* \@departmentname@CS}
    \fi
    \ifslovak
      {\bfseries \@uhk@SK \\* \@fim@SK \\* \@departmentname@SK}
    \fi
    \ifenglish
      {\bfseries \@uhk@EN \\* \@fim@EN \\* \@departmentname@EN}
    \fi
    
    \vspace{6.5cm}
    
    \ifczech
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@title@CS}
    \fi
    \ifslovak
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@title@CS}
    \fi
    \ifenglish
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{16} \@title@EN}
    \fi

	\ifx\empty\@subtitle\else
    
    \vspace{3mm}
    
    \ifczech
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@subtitle}
    \fi
    \ifslovak
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@subtitle}
    \fi
    \ifenglish
      {\bfseries \fontfamily{qhv}\selectfont \setfontsize{14} \@subtitle}
    \fi
    
    \fi
      
    \vspace{3mm}
    
    \ifczech
      {\fontfamily{qhv}\selectfont \setfontsize{14} \@projecttype@CS}
    \fi
    \ifslovak
      {\fontfamily{qhv}\selectfont \setfontsize{14} \@projecttype@SK}
    \fi
    \ifenglish
      {\fontfamily{qhv}\selectfont \setfontsize{14} \@projecttype@EN}
    \fi
\end{center}

\vspace{4.5cm}

\ifslovak\@author@SK\else\ifczech\@author@CS\else\@author@EN\fi\fi: \get@author

\ifslovak\@authorfield@SK\else\ifczech\@authorfield@CS\else\@authorfield@EN\fi\fi: \@author@field

\vfill

\ifslovak\@supervisor@SK\else\ifczech\@supervisor@CS\else\@supervisor@EN\fi\fi: \get@supervisor
  
\vfill
\vfill
Hradec Králové \hfill \@year

\iftwoside
  \cleardoublepage
  \pagestyle{plain}
\else
  \newpage
\fi

%=================================================================================

\makedeclaration

\makeannotation
\clearpage
\setcounter{tocdepth}{2}\setcounter{page}{1}
}

%=================================================================================

%-----------------------------------------------------------------------------
% Uvozovky / Quotation marks
%-----------------------------------------------------------------------------
\def\uv#1{\iflanguage{english}{``#1''}%
                              {\quotedblbase #1\textquotedblleft}}%
%\catcode`\"=\active
%\def"{\bgroup
%    \iflanguage{english}%
%        {``\def"{''\egroup}}%
%        {\quotedblbase\def"{\textquotedblleft\egroup}}}

% Now, switch on what is appropriate for czech:

% czech quotation marks
% \bq - begin quotation, \eq - end quotation
\def\bq{\mbox{\kern.1ex\protect\raisebox{-1.3ex}[0pt][0pt]{''}\kern-.1ex}}
\def\eq{\mbox{\kern-.1ex``\kern.1ex}}
%\setlanguage{\czech}

{%                                      % Begin a group for which " is active
\catcode`\"=\active                     % Make " an active character
\catcode`\@=11                          % Make @ an active character
%
%  \csdoublequoteson
%
%       This macro makes " an active character, resets the control sequence
%       \dblqu@te to L (left), and defines \dq as a replacement for ".
%
\gdef\csdoublequoteson{%                % \csdoublequoteson enables "
    \gdef"{\czechquotes}%               % Define " as \czechquotes
    \global\catcode`\"=\active%         % Make " an active character
    \global\chardef\dq=`\"%             % Double-quote char. via \dq
    \global\let\dblqu@te=L%             % Always start with a left double-quote
    }                                   % End of macro
%
%  \bq, \eq
%
%      These macros define default characters for czech left and right
%      double quotes. Czech opening quote is created from two commas with
%      kerning depending on fontdimen four parameter of current font.
%      Better solution should be specially designed character with
%      proper kernings; if you have such characters in fonts
%      (e.g. in DC-fonts), use it instead. (e.g. define
%      macros \bq and \eq e.g. \def\bq{\char"130 }
%      in your document/style file-- not in csquote.sty!)
%      Similar solution is used for czech right quote.
%
%      \cs existence test, stolen from TeXbook exercise 7.7
\def\ifundefined#1{\expandafter\ifx\csname#1\endcsname\relax }%
%
%      another macro to be more efficient in time and space
\global\chardef\f@@r=4
%
\ifundefined{bq}%
\gdef\bq{\kern-.25\fontdimen\f@@r\font,\kern-.8\fontdimen\f@@r\font,%
                \kern-.35\fontdimen\f@@r\font}%
\fi
\ifundefined{eq}%
\gdef\eq{\kern-.35\fontdimen\f@@r\font`\kern-.8\fontdimen\f@@r\font`%
                \kern-.25\fontdimen\f@@r\font}
\fi
%
% Macro \uv for other usage of \bq and \eq.
%
\ifundefined{uv}\iflanguage{czech}%
        \gdef\uv#1{\bq #1\eq}
\fi
%
% \testquotes macro gives warning if citation span this place
%
\gdef\testquotes{\if R\dblqu@te
        \message{Warning: You forgot right double quote!}%
        \let\dblqu@te=L\fi}
%
%  Define the macro that will be executed whenever " is encountered.
%
\gdef\czechquotes{\protect\czechqu@tes}
\gdef\czechqu@tes{%
        %  If the double-quote is the first character in a new paragraph,
        %  make sure it becomes a left double-quote.  This case can be
        %  detected by checking to see if TeX is currently in vertical mode.
        %  If so, the double-quote is at the beginning of the paragraph
        %  (since " hasn't actually generated any horizontal mode tokens
        %  yet, TeX is still in vertical mode).  If the mode is vertical,
        %  set \dblqu@te equal to L.
        %
        \ifinner\else\ifvmode\testquotes\fi\fi%
        %
        %  Now insert the appropriate left or right double-quote.
        %
        %  If \dblqu@te is L, insert an opening quote and set \dblqu@te to R.
        %
        \if L\dblqu@te\bq\global\let\dblqu@te=R%
        %
        %  Otherwise, save the current \spacefactor, insert '', set \dblqu@te
        %  to L, and reset the original \spacefactor.
        %
        \else%
           \let\xxx=\spacefactor%               % Save the \spacefactor
           \eq%                                 % Insert ending quote
           \global\let\dblqu@te=L%              % and reset \dblqu@te
           \spacefactor\xxx%                    % Reset the \spacefactor
        \fi%                                    % End of \if L\dblqu@te...
        }                                       % End of " macro
}                                               % End of group

\gdef\csdoublequotesoff{%
        \catcode`\"=12%                         % Set " back to other
        }
%
% Czech quotes are default
%
\csdoublequoteson

% zavedení příkazu \csquotes jako přímé citace zdroje (text v českých uvozovkách a v kurzívě)
\newcommand{\csquotes}[1]{\textit{\uv{#1}}}

%--------------------------------------------------------
% Oprava pro Čechy a Slováky
% Fix for CZECH and SLOVAK
% http://tex.stackexchange.com/questions/111999/slovak-and-czech-babel-gives-problems-with-cmidrule-and-cline
%--------------------------------------------------------
\usepackage{regexpatch}
%\ifczechslovak
  \makeatletter
  % Change the `-` delimiter to an active character
  \xpatchparametertext\@@@cmidrule{-}{\cA-}{}{}
  \xpatchparametertext\@cline{-}{\cA-}{}{}
  \makeatother
%\fi

\ifczechslovak
  \renewcommand{\lstlistingname}{Výpis} %Výpis místo Listing
\fi


%--------------------------------------------------------
% Zdrojové kódy / Listings
%--------------------------------------------------------

% BEGIN Jan Pluskal (ipluskal) listings

\definecolor{bluekeywords}{rgb}{0.13,0.13,1}
\definecolor{greencomments}{rgb}{0,0.5,0}
\definecolor{redstrings}{rgb}{0.9,0,0}

\definecolor{gray}{rgb}{0.4,0.4,0.4}
\definecolor{darkblue}{rgb}{0.0,0.0,0.6}
\definecolor{cyan}{rgb}{0.0,0.6,0.6}

\lstset{
  basicstyle=\ttfamily,
  columns=fullflexible,
  showstringspaces=false,
  commentstyle=\color{gray}\upshape,
  captionpos=b
}

\lstdefinestyle{csh}{language=[Sharp]C,
  showspaces=false,
  showtabs=false,
  breaklines=false,
  showstringspaces=false,
  breakatwhitespace=true,
  escapeinside={(*@}{@*)},
  commentstyle=\color{greencomments},
  keywordstyle=\color{bluekeywords},
  stringstyle=\color{redstrings},
  basicstyle=\ttfamily,
  captionpos=b,
  numbers=left,
  frame=single,
}

\lstdefinelanguage{XML}
{
  morestring=[b]",
  morestring=[s]{>}{<},
  morecomment=[s]{<?}{?>},
  stringstyle=\color{black},
  identifierstyle=\color{darkblue},
  keywordstyle=\color{cyan},
  morekeywords={xmlns,version,type} % list your attributes here
}

\lstdefinestyle{npl}{language=c,
  showspaces=false,
  showtabs=false,
  breaklines=true,
  showstringspaces=false,
  breakatwhitespace=true,
  escapeinside={(*@}{@*)},
  commentstyle=\color{greencomments},
  keywordstyle=\color{bluekeywords},
  stringstyle=\color{redstrings},
  basicstyle=\ttfamily,
  captionpos=b,
  numbers=left,
  frame=single,
  morekeywords={UINT8, UINT16, UINT32, INT8, INT16, INT32, Post, Properties, Protocol, AsciiString, String, StringTerm, BLOB, FormatString, this},
}


\lstdefinestyle{c++}{language=c,
  showspaces=false,
  showtabs=false,
  breaklines=true,
  showstringspaces=false,
  breakatwhitespace=true,
  escapeinside={(*@}{@*)},
  commentstyle=\color{greencomments},
  keywordstyle=\color{bluekeywords},
  stringstyle=\color{redstrings},
  basicstyle=\ttfamily,
  captionpos=b,
  numbers=left,
  frame=single,
  morekeywords={UINT8, UINT16, UINT32, INT8, INT16, INT32, Post, Properties, Protocol, AsciiString, String, StringTerm, BLOB, FormatString, this},
}

%END Jan Pluskal (ipluskal) listings

%--------------------------------------------------------

% Příkazy pro TODO (3 alternativy - lze zvolit preferovanou)
% commands for TODO (3 alternatives - preferred one can be selected)
\newcommand{\todo}[1]{\textcolor{red}{\textbf{[[TODO #1]]}}}
\newcommand{\TODO}{\textcolor{red}{\textbf{[[TODO]]}}}
%\usepackage[colorinlistoftodos,prependcaption,textsize=tiny, disable]{todonotes}
%\usepackage[colorinlistoftodos,prependcaption,textsize=tiny]{todonotes}

\newcommand{\phony}[1]{\textcolor{gray}{#1}}
\newcommand{\blind}[1]{\textcolor{gray}{\Blindtext[#1]}}

% Sloupec zarovnaný vlevo s pevnou šířkou
% Left aligned column with a fixed width
\newcolumntype{L}[1]{>{\RaggedRight\hspace{0pt}}p{#1}}

\endinput
%%
