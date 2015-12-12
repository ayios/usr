define main ()
{
  variable
    dir,
    bat,
    charging,
    remain,
    capacity,
    sysorproc = access ("/proc/acpi/battery/", F_OK);

  if (-1 == sysorproc)
    {
    dir = "/sys/class/power_supply";
    bat = listdir (dir);

    bat = (NULL == bat || 0 == length (bat)) ? NULL :
    array_map (String_Type, &sprintf, "%s/%s/%s", dir, bat[1],
      ["capacity", "status"]);

    if (NULL == bat)
      {
      IO.tostderr ("I didn't found any battery");
      exit_me (1);
      }

    charging = IO.readfile (bat[1])[0];
    capacity = IO.readfile (bat[0])[0];
    remain = (Integer_Type == _slang_guess_type (capacity)) ?
      sprintf ("%.0f%%", integer (capacity)) : "0%";
    }
  else
    {
    dir = "/proc/acpi/battery/";
    bat = listdir (dir)[0];

    bat = (NULL == bat || 0 == length (bat)) ? NULL :
    array_map (String_Type, &sprintf, "%s/%s/%s", dir, bat,
      ["state", "info"]);

    if (NULL == bat)
      {
      IO.tostderr ("I didn't found any battery");
      exit_me (1);
      }

    variable
      line_state = IO.readfile (bat[0]; end = 5)[[2:]],
      line_info = IO.readfile (bat[1]; end = 3)[-1];

    charging = strtok (line_state[0])[-1];
    capacity = strtok (line_state[2])[-2];
    remain = (Integer_Type == _slang_guess_type (capacity)) ?
      sprintf ("%.0f%%", 100.0 / integer (strtok (line_info)[-2])
          * integer (capacity)) : "0%";
    }
 
  IO.tostdout (sprintf ("[Battery is %S, remaining %S]", charging, remain));
  exit_me (0);
}
