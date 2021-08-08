set history save
set history filename ~/.gdb_history

set auto-load safe-path /

define hook-quit
    set confirm off
end

define hookpost-break
  save break breakpoints.gdb
end
define hookpost-delete
  save break breakpoints.gdb
end

layout src
layout regs
focus next


#set disassembly-flavor intel

#target remote localhost:2331
