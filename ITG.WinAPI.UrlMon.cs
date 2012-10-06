﻿using System; 
using System.IO; 
using System.Runtime.InteropServices; 

namespace ITG.WinAPI.UrlMon {

[Flags]
public enum FMFD {
    Default = 0x00000000, // No flags specified. Use default behavior for the function. 
    URLAsFileName = 0x00000001, // Treat the specified pwzUrl as a file name. 
    EnableMIMESniffing = 0x00000002, // Internet Explorer 6 for Windows XP SP2 and later. Use MIME-type detection even if FEATURE_MIME_SNIFFING is detected. Usually, this feature control key would disable MIME-type detection. 
    IgnoreMIMETextPlain = 0x00000004, // Internet Explorer 6 for Windows XP SP2 and later. Perform MIME-type detection if "text/plain" is proposed, even if data sniffing is otherwise disabled. Plain text may be converted to text/html if HTML tags are detected. 
    ServerMIME = 0x00000008, // Internet Explorer 8. Use the authoritative MIME type specified in pwzMimeProposed. Unless FMFD_IGNOREMIMETEXTPLAIN is specified, no data sniffing is performed. 
    RespectTextPlain = 0x00000010, // Internet Explorer 9. Do not perform detection if "text/plain" is specified in pwzMimeProposed. 
    RetrunUpdatedImgMIMEs = 0x00000020 // Internet Explorer 9. Returns image/png and image/jpeg instead of image/x-png and image/pjpeg. 
};

public
class API {

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
	[MarshalAs(UnmanagedType.U4)] System.UInt32 cbSize,
	[MarshalAs(UnmanagedType.LPWStr)] System.Text.StringBuilder pwzMimeProposed,
	[MarshalAs(UnmanagedType.U4)] System.UInt32 dwMimeFlags,
	out System.UInt32 ppwzMimeOut,
	[MarshalAs(UnmanagedType.U4)] System.UInt32 dwReserverd
);

}
}
