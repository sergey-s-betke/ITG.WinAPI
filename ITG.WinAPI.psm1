Add-Type @" 

using System; 
using System.Runtime.InteropServices; 

namespace ITG {

public class WinAPI { 
	
	// http://msdn.microsoft.com/en-us/library/windows/desktop/ms633545(v=vs.85).aspx
	[DllImport("user32.dll")] 
	[return: MarshalAs(UnmanagedType.Bool)] 
	public
	static
	extern
	bool
	SetWindowPos(
		IntPtr hWnd, 
		IntPtr hWndInsertAfter,
		int x, int y, 
		int cx, int cy, 
		uint uFlags
	);

	// http://msdn.microsoft.com/en-us/library/windows/desktop/ms633539(v=vs.85).aspx
	[DllImport("user32.dll")] 
	[return: MarshalAs(UnmanagedType.Bool)] 
	public
	static
	extern
	bool
	SetForegroundWindow(
		IntPtr hWnd
	);

} 

}

"@;

Export-ModuleMember `
;
