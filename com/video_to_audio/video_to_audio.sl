load.from ("proc", "procInit", NULL;err_handler = &__err_handler__);

private define parse_time (tim, sec)
{
  variable
    i,
    t,
    form = [23, 59, 59],
    secst = [60 * 60, 60, 1];

  _for i (0, 2)
    ifnot (tim[i] == "00")
      if (1 > atoi (tim[i]))
        {
        IO.tostderr (sprintf ("%s: wrong time format", strjoin (tim, ":")));
        return NULL;
        }
      else
        if (atoi (tim[i]) > form[i] || atoi (tim[i]) < 0)
          {
          IO.tostderr (sprintf ("%s: wrong time format", strjoin (tim, ":")));
          return NULL;
          }
        else
          @sec += atoi (tim[i]) * secst[i];

  tim = strjoin (tim, ":");

  return tim;
}

define main ()
{
  variable ffmpeg = Sys.which ("ffmpeg");
 
  if (NULL == ffmpeg)
    {
    ffmpeg = Sys.which ("avconv");
    if (NULL == ffmpeg)
      {
      IO.tostderr ("ffmpeg and|or avconv hasn't been found in PATH");
      exit_me (1);
      }
    }

  variable
    ext,
    verbose = "quiet",
    retval,
    seca = 0,
    secb = 0,
    format = "ogg",
    removesource = 0,
    input = NULL,
    output = NULL,
    end = NULL,
    start = NULL,
    duration = NULL,
    gotopager = 0,
    exts = [".mp4", ".flv", ".webm", ".avi"],
    argv = [ffmpeg],
    c = cmdopt_new (&_usage);

  c.add ("tomp3", &format;default="mp3");
  c.add ("removesource", &removesource);
  c.add ("start", &start;type = "string");
  c.add ("end", &end;type = "string");
  c.add ("input", &input;type = "string");
  c.add ("output", &output;type = "string");
  c.add ("v|verbose", &verbose;default = "info");
  c.add ("info", &info);
  c.add ("help", &_usage);
 
  () = c.process (__argv, 1);
 
  if (NULL == input)
    {
    IO.tostderr ("--input=filename arg is required");
    exit_me (1);
    }

  if (-1 == access (input, F_OK|R_OK))
    {
    IO.tostderr (errno_string (errno));
    exit_me (1);
    }

  if (0 == any (path_extname (input) == exts))
    {
    IO.tostderr (sprintf ("%s extension isn't supported", path_extname (input)[[1:]]));
    exit_me (1);
    }

  if (NULL == output)
    output = input;

  ifnot (NULL == start)
    {
    start = strchop (start, ':', 0);
    ifnot (3 == length (start))
      {
      IO.tostderr ("wrong time format in --start option, setting to NULL");
      start = NULL;
      }
    }
 
  ifnot (NULL == end)
    {
    end = strchop (end, ':', 0);
    ifnot (3 == length (end))
      {
      IO.tostderr ("wrong time format in --end option, setting to NULL");
      end = NULL;
      }
    }

  ifnot (NULL == start)
    {
    start = parse_time (start, &seca);
    if (NULL == start)
      exit_me (1);
    }

  if (NULL != end && start != NULL)
    {
    end = parse_time (end, &secb);
    if (NULL == end)
      exit_me (1);

    if (secb > seca)
      duration = string (secb - seca);

    IO.tostderr (string (seca) + " " + string (secb) + " " + string (duration));
    }

  output = sprintf ("%s/%s.%s", path_dirname (output), path_basename_sans_extname (output),
    format);

  ifnot (access (output, F_OK))
    {
    variable chr = ask ([sprintf ("%s: exists, overwrite? y/n", output)], ['y', 'n']);
    if ('n' == chr)
      {
      IO.tostderr ("aborting ... ");
      exit_me (1);
      }
    }

  format = "ogg" == format ? "libvorbis" : "libmp3lame";

  ifnot (NULL == start)
    argv = [argv, "-ss", start];

  argv = [argv, "-i", input, "-y", "-vn", "-c:a", format, "-loglevel", verbose];

  ifnot (NULL == duration)
    argv = [argv, "-t", duration, output];
  else
    argv = [argv, output];

  variable p = proc->init (0, openstdout, 0);
 
  if (openstdout)
    initproc (p);
 
  send_msg_dr ("press q to to stop converting");

  variable status = p.execv (argv, NULL);

  send_msg_dr (" ");

  ifnot (status.exit_status)
    if (removesource)
      if (-1 == remove (input))
        IO.tostderr (sprintf ("%s: failed to remove, %s", path_basename (input),
          errno_string (errno)));

  exit_me (status.exit_status);
}
