#include "AVPTesterApp.h"
#include "wx/splash.h"

//(*AppHeaders
#include "AVPTesterMain.h"
#include <wx/stdpaths.h>
#include <wx/image.h>
//*)

IMPLEMENT_APP(AVPTesterApp);

bool AVPTesterApp::OnInit()
{
    //(*AppInitialize
    bool wxsOK = true;
    wxInitAllImageHandlers();
    if ( wxsOK )
    {
        #ifdef __WXMSW__
        wxString imgPath(wxT("UI\\splash.bmp"));
        wxBitmap spImg = wxBitmap(imgPath, wxBITMAP_TYPE_BMP);
        #else
        wxString imgPath(wxStandardPaths::Get().GetResourcesDir() + wxT("/UI/splash.png"));
        wxBitmap spImg = wxBitmap(imgPath, wxBITMAP_TYPE_PNG);
        #endif

        wxSplashScreen* splasher = new wxSplashScreen(spImg, wxSPLASH_CENTRE_ON_SCREEN, 1000, NULL, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxSIMPLE_BORDER | wxSTAY_ON_TOP);

        AVPTesterFrame* Frame = new AVPTesterFrame(0);

        splasher->Close();

        Frame->Show();

        SetTopWindow(Frame);
    }
    //*)
    return wxsOK;
}
