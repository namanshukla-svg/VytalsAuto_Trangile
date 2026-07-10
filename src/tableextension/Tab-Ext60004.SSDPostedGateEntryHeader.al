tableextension 60004 "SSD Posted Gate Entry Header" extends "Posted Gate Entry Header"
{
    fields
    {
        field(60000; "SSD Driver Code"; Code[10])
        {
            Caption = 'Driver Code';
            DataClassification = CustomerContent;
            TableRelation = "SSD Driver";
            Editable = false;
        }
        field(60001; "SSD Driver Name"; Text[100])
        {
            Caption = 'Driver Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60010; "SSD Vehicle No."; Code[20])
        {
            Caption = 'Vehicle No.';
            DataClassification = CustomerContent;
            TableRelation = "SSD Vehicle";
            Editable = false;
        }
        field(60030; "SSD Vehicle Status"; Enum "SSD Vehicle Status")
        {
            Caption = 'Vehicle Status';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60031; "SSD Planning No."; Code[20])
        {
            Caption = 'Planning No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60050; "SSD Dock No."; Code[20])
        {
            Caption = 'Dock No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60051; "SSD Time Slot No."; Code[20])
        {
            Caption = 'Time Slot No.';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60052; "SSD Time Slot Starting Time"; Time)
        {
            Caption = 'Time Slot Starting Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60053; "SSD Time Slot Ending Time"; Time)
        {
            Caption = 'Time Slot Ending Time';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60054; "SSD Material Type"; Enum "SSD Item Sub Type")
        {
            Caption = 'Material Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60070; "SSD Gate Out DateTime"; DateTime)
        {
            Caption = 'Gate Out DateTime';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(60092; "SSD Vehicle In"; MediaSet)
        {
            Caption = 'Vehicle In';
        }
        field(60102; "SSD Vehicle Out"; MediaSet)
        {
            Caption = 'Vehicle Out';
        }
        field(60112; "SSD Source Document"; MediaSet)
        {
            Caption = 'Source Document';
        }
    }
    procedure PostInwardGateOut(PostedGateEntryHeader: Record "Posted Gate Entry Header")
    var
        // SSDDockLines: Record "SSD Dock Lines";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        DockActionErr: Label 'There is dock entry open for this Gate Entry. You cannot post Gate-Out';
        OpenReceiptMsg: Label 'Warehouse Receipt %1 is not fully posted. Do you wany to continue', Comment = '%1 = Warehouse Receipt No.';
        PostMsg: Label 'Gate out posted successfully';
    begin
        PostedGateEntryHeader.TestField("SSD Vehicle Status", "SSD Vehicle Status"::"Gate-In");
        if WarehouseReceiptHeader.Get(PostedGateEntryHeader."SSD Planning No.") then
            // if WarehouseReceiptHeader."SSD Material Type" = WarehouseReceiptHeader."SSD Material Type"::"Non-Bulk" then
            if not Confirm(StrSubstNo(OpenReceiptMsg, PostedGateEntryHeader."SSD Planning No."), false) then
                Error('Posting Stopped');
        // SSDDockLines.SetRange("Gate Entry No.", PostedGateEntryHeader."No.");
        // SSDDockLines.SetFilter(Status, '<>%1', SSDDockLines.Status::"Dock Out");
        // if not SSDDockLines.IsEmpty then
        //Error(DockActionErr);
        PostedGateEntryHeader."SSD Vehicle Status" := PostedGateEntryHeader."SSD Vehicle Status"::"Gate-Out";
        PostedGateEntryHeader."SSD Gate Out DateTime" := CurrentDateTime;
        PostedGateEntryHeader.Modify();
        Message(PostMsg);
    end;

    procedure PostOutwardGateOut(PostedGateEntryHeader: Record "Posted Gate Entry Header")
    var
      //  SSDDockLines: Record "SSD Dock Lines";
        DockActionErr: Label 'There is dock entry open for this Gate Entry. You cannot post Gate-Out';
        PostMsg: Label 'Gate out posted successfully';
    begin
        // SSDDockLines.SetRange("Gate Entry No.", PostedGateEntryHeader."No.");
        // SSDDockLines.SetFilter(Status, '%1|%2', SSDDockLines.Status::Completed, SSDDockLines.Status::"Dock Out");
        // if SSDDockLines.FindFirst() then begin
        //     SSDDockLines.Status := SSDDockLines.Status::"Dock Out";
        //     SSDDockLines.Modify();
        // end
        // else
        //     Error(DockActionErr);
        PostedGateEntryHeader."SSD Vehicle Status" := PostedGateEntryHeader."SSD Vehicle Status"::"Gate-Out";
        PostedGateEntryHeader."SSD Gate Out DateTime" := CurrentDateTime;
        PostedGateEntryHeader.Modify();
        Message(PostMsg);
    end;
}
