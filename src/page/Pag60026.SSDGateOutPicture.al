page 60026 "SSD Gate Out Picture"
{
    Caption = 'Gate-Out Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Gate Entry Header";

    layout
    {
        area(Content)
        {
            field(Picture; Rec."SSD Vehicle Out")
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the driver.';
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable and (HideActions = false);

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = false;

                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;
    trigger OnOpenPage()
    begin
        CameraAvailable:=Camera.IsAvailable();
    end;
    var Camera: Codeunit Camera;
    CameraAvailable: Boolean;
    DeleteExportEnabled: Boolean;
    HideActions: Boolean;
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
        if Rec."SSD Vehicle Out".Count() > 0 then if not Confirm(OverrideImageQst)then exit(false);
        if Camera.GetPicture(PictureInstream, PictureDescription)then begin
            Clear(Rec."SSD Vehicle Out");
            Rec."SSD Vehicle Out".ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;
        exit(false);
    end;
    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled:=Rec."SSD Vehicle Out".Count <> 0;
    end;
    procedure IsCameraAvailable(): Boolean begin
        exit(Camera.IsAvailable());
    end;
    procedure SetHideActions()
    begin
        HideActions:=true;
    end;
    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");
        if not Confirm(DeleteImageQst)then exit;
        Clear(Rec."SSD Vehicle Out");
        Rec.Modify(true);
    end;
}
