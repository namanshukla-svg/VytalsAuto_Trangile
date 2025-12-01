page 60031 "SSD Posted Gate In Picture"
{
    Caption = 'Posted Gate-In Picture';
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Posted Gate Entry Header";

    layout
    {
        area(Content)
        {
            field(Picture; Rec."SSD Vehicle In")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the Gate In.';
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;
    trigger OnOpenPage()
    begin
    // CameraAvailable := Camera.IsAvailable();
    end;
    var Camera: Codeunit Camera;
    //  CameraAvailable: Boolean;
    // DeleteExportEnabled: Boolean;
    // HideActions: Boolean;
    DeleteImageQst: Label 'Are you sure you want to delete the picture?';
    MimeTypeTok: Label 'image/jpeg', Locked = true;
    OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField("SSD Planning No.");
        DoTakeNewPicture();
    end;
    local procedure DoTakeNewPicture(): Boolean var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        if Rec."SSD Vehicle In".Count() > 0 then if not Confirm(OverrideImageQst)then exit(false);
        if Camera.GetPicture(PictureInstream, PictureDescription)then begin
            Clear(Rec."SSD Vehicle In");
            Rec."SSD Vehicle In".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;
        exit(false);
    end;
    local procedure SetEditableOnPictureActions()
    begin
    //   DeleteExportEnabled := Rec."SSD Vehicle In".Count <> 0;
    end;
    procedure IsCameraAvailable(): Boolean begin
        exit(Camera.IsAvailable());
    end;
    // procedure SetHideActions()
    // begin
    //     HideActions := true;
    // end;
    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");
        if not Confirm(DeleteImageQst)then exit;
        Clear(Rec."SSD Vehicle In");
        Rec.Modify(true);
    end;
}
