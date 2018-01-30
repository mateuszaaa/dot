

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Virtual PC</title>
    <link rel="SHORTCUT ICON" href="/Citrix/AccessPlatform/site/icons.aspx?size=small&amp;id=idKEJJNKLODOBHJBDKLDIMEGJIDFFOCJIG" type="image/png">
      <script type="text/javascript" src="javascript.aspx?cacheString=en++Normal++ywBx6S85sUw5jFW2vwYH6A++fynGTCf76+NVEIH8XmlAdA++authenticated"></script>
  <script type="text/javascript">
    <!--
    // Ensure every page has an onLoadLayout function. If a page defines its own
    // onLoadLayout function, it will override this one.
    function onLoadLayout() {
      return;
    }
    function getFrameSuffix() {
      return "WI_okUUyIte49_R8siC7";
    }
    function getSessionToken() {
      return "69DAAE71E86824BF83E4FA520D58FEA6";
    }
    // -->
  </script>
    <script type="text/javascript">
        <!--
        

function onLoadLayout()
{
}


function appEmbed(mylink, width, height)
{
    var scrollable = "no";
    if (width > window.screen.availWidth) {
        scrollable = "yes";
        width = window.screen.availWidth - 10;
    }
    if (height > window.screen.availHeight) {
        scrollable = "yes";
        height = window.screen.availHeight - 30;
    }
    var win = window.open(mylink, '_blank', 'width=' + width + ',height=' + height + ',scrollbars=' + scrollable + ',status=no,resizable=no,toolbar=no');
    if (win != null) {
        try {
            win.moveTo(window.screen.availLeft, window.screen.availTop);
        } catch (e) {
            // Ignore exception caused by this page being in a different zone to the opened window. (RDP Trusted Sites issue).
        }
    }
    return win;
}


// Check if we are in the main frame in WI (i.e. not hidden frames)
// If so, redirect to a hidden one so that we can still see the WI default page

function checkFrameName() {
    if ("y" == "y")
    {
        if (findMainFrame(window) == null) {
            redirectToMainFrame("default.aspx?CTX_MessageType=WARNING&CTX_MessageKey=ShortcutDisabled")
        } else {
          document.location.replace('/Citrix/AccessPlatform/site/launch.ica?CTX_Application=Citrix.MPS.Desktop.FIESWAH003.VPC%20Europe&CTX_AppFriendlyNameURLENcoded=Virtual%20PC&CTX_Token=69DAAE71E86824BF83E4FA520D58FEA6&LaunchId=1463568660318');
        }
    } else
    {
        
        redirectToMainFrame("");
    }
}
        // -->
    </script>
</head>

<body onload="setTimeout('checkFrameName();',0);">
</body>
</html>
