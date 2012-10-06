using System; 
using System.IO; 
using System.Runtime.InteropServices; 

namespace ITG.WinAPI {

public
class UrlMon {

// http://msdn.microsoft.com/en-us/library/ms775107(VS.85).aspx
// http://social.msdn.microsoft.com/Forums/en-US/Vsexpressvcs/thread/d79e76e3-b8c9-4fce-a97d-94ded18ea4dd
[DllImport("urlmon.dll", CharSet = CharSet.Auto)]
public
static 
extern
System.UInt32 
FindMimeFromData(
	System.UInt32 pBC,
	[MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pwzUrl,
	[MarshalAs(UnmanagedType.LPArray)] byte[] pBuffer,
	System.UInt32 cbSize,
	[MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pwzMimeProposed,
	System.UInt32 dwMimeFlags,
	out System.UInt32 ppwzMimeOut,
	System.UInt32 dwReserverd
);

}

}
