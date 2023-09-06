##' Check system dependencies necessary for package 'glatos' 
##'
##' Checks to make sure external dependencies required by functions in
##' 'glatos' are installed and available to R.
##'
##' @details `check_dependencies` checks that ffmpeg (cross platform software
##'   for manipulating video content) software are installed on your
##'   computer and accessible to R. FFmpeg is required to create or modify video
##'   animations of fish movement using the `make_frames`,
##'   `make_video`, and `adjust_video_playback` functions.
##'
##' @details When `check_dependencies` is executed, R attempts to
##'   sequentially access the external libraries.  If the libraries
##'   are installed and accessible, a message is returned to the
##'   terminal stating that the check was successful. Failed attempts
##'   to access the external libraries are printed to the terminal.
##'   
##' @details The simplest way to install FFMPEG for use by the 'glatos' package
##'   functions is to use the `install_ffmpeg` function, which downloads
##'   the excecutable from one of the websites listed below (depending on
##'   operating system) and places it in the 'glatos' package directory.
##'   `make_video` and other `glatos` functions that call ffmpeg will
##'   from that location. The downside to this method is that
##'   `install_ffmpeg` will need to be run each time the `glatos`
##'   package is re-installed. For more permanent installations of FFMPEG, see
##'   directions below, by operating system.
##'   
##' @details Full installation of the ffmpeg library on windows is
##'   accomplished by downloading the recent 'static' build from
##'   <http://ffmpeg.zeranoe.com/builds/>. After the download is
##'   complete, use your favorite compression utility to extract the
##'   downloaded folder. Decompress the package and store contents on
##'   your computer.  Last, edit your system path variable to include
##'   the path to the directory containing ffmpeg.exe
##'
##' @details Full installation of ffmpeg on Mac is similar to
##'   windows. First, download most recent build from
##'   <http://www.evermeet.cx/ffmpeg/>.  The binary files are
##'   compressed with 7zip so may need toinstall an unarchiving
##'   utility (<http://wakaba.c3.cx/s/apps/unarchiver.html>) to
##'   extract the program folder. After the folder is extracted, copy
##'   the ffmpeg folder to /usr/local/bin/ffmpeg on your machine.
##' 
##' @return A message is printed to the console.
##' 
##' @author Todd Hayden, Chris Holbrook
##'
##' @examples
##'\dontrun{
##' # run check
##' check_dependencies() 
##' }
##'
##' @export



check_dependencies <- function(...){

  # FFmpeg is no longer needed.  Function is now deprecated
  .Defunct(new = NA, msg = "ffmpeg dependency is no longer needed by glatos package")
  
  
  # check for ffmpeg
  message("Checking for ffmpeg...")
  ffmpeg <- tryCatch(list(found = TRUE, value = glatos:::get_ffmpeg_path(NA)), 
                     error = function(e) list(found = FALSE, value = e$message))
                         
  
  # print message with result
  if(ffmpeg$found) { 
    message(" OK... FFmpeg is installed at \n  ", ffmpeg$value, ".", "\n") 
  } else {
    message(ffmpeg$value, "\n")
  }
  
}
