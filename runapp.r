# /usr/bin/r
#
# Created: 2016.02.09
# Copyright: Steven E. Pav, 2016
# Author: Steven E. Pav <shabbychef@gmail.com>
# Comments: Steven E. Pav

suppressMessages(library(docopt))       

doc <- "Usage: runapp.r [-q] [-r] [-H <HOST>] [-p <PORT>] [-a <APPDIR>] [-d <DISPLAYMODE>] 

-H HOST --host=HOST                        Launch the app on the given host [default: 0.0.0.0]
-p PORT --port=PORT                        Launch the app on the given port [default: 5555]
-a APPDIR --appdir=APPDIR                  Launch the app in the given directory [default: /srv/shiny]
-d DISPLAYMODE --displaymode=DISPLAYMODE   Launch the app with the given display.mode [default: normal]
-q --quiet                                 Launch app with quiet option.
-r --reactlog                              Set options to show shiny.reactlog.
-h --help                                  show this help text and exit"

opt <- docopt(doc)

if (opt$reactlog) {
	options(shiny.reactlog=TRUE)
}

if (opt$quiet) {
	suppressMessages(library(shiny))
} else {
	library(shiny)
}

shiny::runApp(appDir=opt$appdir,
							port=as.numeric(opt$port),
							host=opt$host,
							launch.browser=FALSE,
							quiet=opt$quiet,
							display.mode=opt$displaymode)

#for vim modeline: (do not edit)
# vim:fdm=marker:fmr=FOLDUP,UNFOLD:cms=#%s:syn=r:ft=r
