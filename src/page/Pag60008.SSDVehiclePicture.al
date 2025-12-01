page 60008 "SSD Vehicle Picture"
{
    Caption = 'Vehicle Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "SSD Vehicle";

    layout
    {
        area(Content)
        {
            field(Picture; Rec.Picture)
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
                    DeleteVehiclePicture();
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
        Rec.TestField(Code);
        OnAfterTakeNewPicture(Rec, DoTakeNewPicture());
    end;
    local procedure DoTakeNewPicture(): Boolean var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        if Rec.Picture.Count() > 0 then if not Confirm(OverrideImageQst)then exit(false);
        if Camera.GetPicture(PictureInstream, PictureDescription)then begin
            Clear(Rec.Picture);
            Rec.Picture.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true);
            exit(true);
        end;
        exit(false);
    end;
    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled:=Rec.Picture.Count <> 0;
    end;
    procedure IsCameraAvailable(): Boolean begin
        exit(Camera.IsAvailable());
    end;
    procedure SetHideActions()
    begin
        HideActions:=true;
    end;
    procedure DeleteVehiclePicture()
    begin
        Rec.TestField(Code);
        if not Confirm(DeleteImageQst)then exit;
        Clear(Rec.Picture);
        Rec.Modify(true);
        OnAfterDeleteVehiclePicture(Rec);
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteVehiclePicture(var Vehicle: Record "SSD Vehicle")
    begin
    end;
    [IntegrationEvent(false, false)]
    local procedure OnAfterTakeNewPicture(var Vehicle: Record "SSD Vehicle"; IsPictureAdded: Boolean)
    begin
    end;
}
