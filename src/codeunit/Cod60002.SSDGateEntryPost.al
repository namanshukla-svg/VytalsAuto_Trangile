codeunit 60002 "SSD Gate Entry Post"
{
    TableNo = "Gate Entry Header";

    trigger OnRun()
    var
        GateEntryAttachment: Record "Gate Entry Attachment";
        WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        TenantMedia2: Record "Tenant Media";
        NoSeries: Codeunit "No. Series";
    begin
        GateEntryHeader:=Rec;
        Rec.TestField("Posting Date");
        Rec.TestField("Document Date");
        if Rec."Entry Type" = Rec."Entry Type"::Inward then begin
            Rec.TestField("SSD Planning No.");
            Rec.TestField("SSD Driver Code");
            Rec.TestField("SSD Vehicle No.");
        end;
        GateEntryLine.Reset();
        GateEntryLine.SetRange("Entry Type", Rec."Entry Type");
        GateEntryLine.SetRange("Gate Entry No.", Rec."No.");
        if not GateEntryLine.FindFirst()then Error(NothingToPostErr);
        if GateEntryLine.FindSet()then repeat if GateEntryLine."Source Type" <> GateEntryLine."Source Type"::" " then GateEntryLine.TestField("Source No.");
                if GateEntryLine."Source Type" = GateEntryLine."Source Type"::" " then GateEntryLine.TestField(Description);
            until GateEntryLine.Next() = 0;
        if GuiAllowed then Window.Open('#1###########################\\' + PostingLinesLbl);
        if GuiAllowed then Window.Update(1, StrSubstNo(GateEntryNoLbl, GateEntryLbl, Rec."No."));
        if Rec."Posting No. Series" = '' then begin
            Record:=Rec;
            PostingNoSeries.GetPostingNoSeriesCode(Record);
            Rec:=Record;
            Rec.Modify();
        end;
        if Rec."Posting No." = '' then begin
            Rec."Posting No.":=NoSeries.GetNextNo(Rec."Posting No. Series", Rec."Posting Date");
            ModifyHeader:=true;
        end;
        if ModifyHeader then Rec.Modify();
        GateEntryLine.LockTable();
        PostedGateEntryHeader.Init();
        PostedGateEntryHeader.TransferFields(GateEntryHeader);
        PostedGateEntryHeader."No.":=Rec."Posting No.";
        PostedGateEntryHeader."No. Series":=Rec."Posting No. Series";
        PostedGateEntryHeader."Gate Entry No.":=Rec."No.";
        PostedGateEntryHeader."Posting Date":=Today;
        PostedGateEntryHeader."Posting Time":=Time;
        PostedGateEntryHeader."SSD Vehicle Status":=PostedGateEntryHeader."SSD Vehicle Status"::"Gate-In";
        Clear(PostedGateEntryHeader."SSD Vehicle In");
        Clear(PostedGateEntryHeader."SSD Source Document");
        if GuiAllowed then Window.Update(1, StrSubstNo(GateEntryUpdateLbl, Rec."No.", PostedGateEntryHeader."No."));
        PostedGateEntryHeader.Insert();
        if GateEntryHeader."SSD Vehicle In".Count > 0 then begin
            Clear(ImageInstream);
            TenantMedia2.Get(GateEntryHeader."SSD Vehicle In".Item(1));
            TenantMedia2.CalcFields(Content);
            TenantMedia2.Content.CreateInStream(ImageInstream, TextEncoding::UTF8);
            FileName:=PostedGateEntryHeader."No." + '_VI.png';
            PostedGateEntryHeader."SSD Vehicle In".ImportStream(ImageInstream, FileName);
            PostedGateEntryHeader.Modify();
        end;
        if GateEntryHeader."SSD Source Document".Count > 0 then begin
            Clear(ImageInstream);
            TenantMedia2.Get(GateEntryHeader."SSD Source Document".Item(1));
            TenantMedia2.CalcFields(Content);
            TenantMedia2.Content.CreateInStream(ImageInstream, TextEncoding::UTF8);
            FileName:=PostedGateEntryHeader."No." + '_SD.png';
            PostedGateEntryHeader."SSD Source Document".ImportStream(ImageInstream, FileName);
            PostedGateEntryHeader.Modify();
        end;
        GateEntryHandler.CopyCommentLines(Rec."Entry Type", Rec."Entry Type", Rec."No.", PostedGateEntryHeader."No.");
        GateEntryLine.Reset();
        GateEntryLine.SetRange("Entry Type", Rec."Entry Type");
        GateEntryLine.SetRange("Gate Entry No.", Rec."No.");
        LineCount:=0;
        if GateEntryLine.FindSet()then repeat LineCount+=1;
                if GuiAllowed then Window.Update(2, LineCount);
                PostedGateEntryLine.Init();
                PostedGateEntryLine.TransferFields(GateEntryLine);
                PostedGateEntryLine."Entry Type":=PostedGateEntryHeader."Entry Type";
                PostedGateEntryLine."Gate Entry No.":=PostedGateEntryHeader."No.";
                PostedGateEntryLine.Insert();
                case Rec."Entry Type" of "Gate Entry Type"::Inward: begin
                    GateEntryAttachment.Init();
                    GateEntryAttachment."Source Type":=PostedGateEntryLine."Source Type";
                    GateEntryAttachment."Source No.":=PostedGateEntryLine."Source No.";
                    GateEntryAttachment."Entry Type":=PostedGateEntryLine."Entry Type";
                    GateEntryAttachment."Gate Entry No.":=PostedGateEntryLine."Gate Entry No.";
                    GateEntryAttachment."Line No.":=PostedGateEntryLine."Line No.";
                    GateEntryAttachment."Warehouse Recpt. No.":=Rec."SSD Planning No.";
                    GateEntryAttachment.Insert();
                    if WarehouseReceiptHeader.Get(Rec."SSD Planning No.")then begin
                        WarehouseReceiptHeader."Gate Entry no.":=PostedGateEntryHeader."No.";
                        WarehouseReceiptHeader."Gate Entry Date":=PostedGateEntryHeader."Posting Date";
                        WarehouseReceiptHeader.Modify();
                    end;
                end;
                end;
            until GateEntryLine.Next() = 0;
      //  SSDDockManagment.UpdateDockInwardFromGatePosting(PostedGateEntryHeader);
        Rec.Delete();
        GateEntryLine.DeleteAll();
        if GuiAllowed then Window.Close();
        Rec:=GateEntryHeader;
    end;
    
    procedure ProcessInwardGateOut(QRText: Text)
    var
        PostedGateEntryHeader2: Record "Posted Gate Entry Header";
        PostedGateEntryHeader3: Record "Posted Gate Entry Header";
        DockSuccessTxt: Label 'Vehicle %1 Gate-out successful.', Comment = '%1 = Vehicle No.';
        VehicleNoExistsTxt: Label 'Vehicle %1 does not have pending Gate-Out', Comment = '%1 = Vehicle No.';
    begin
        PostedGateEntryHeader2.SetRange("Entry Type", PostedGateEntryHeader2."Entry Type"::Inward);
        PostedGateEntryHeader2.SetRange("SSD Vehicle No.", QRText);
        if not PostedGateEntryHeader2.FindFirst()then Message(VehicleNoExistsTxt, QRText)
        else
        begin
            PostedGateEntryHeader3.Get(PostedGateEntryHeader2."Entry Type", PostedGateEntryHeader2."No.");
            PostedGateEntryHeader3."SSD Vehicle Status":=PostedGateEntryHeader3."SSD Vehicle Status"::"Gate-Out";
            PostedGateEntryHeader3.Modify();
            Message(DockSuccessTxt, QRText);
        end;
    end;
    var GateEntryHeader: Record "Gate Entry Header";
    GateEntryLine: Record "Gate Entry Line";
    PostedGateEntryHeader: Record "Posted Gate Entry Header";
    PostedGateEntryLine: Record "Posted Gate Entry Line";
    PostingNoSeries: Record "Posting No. Series";
    GateEntryHandler: Codeunit "Gate Entry Handler";
   // SSDDockManagment: Codeunit "SSD Dock Management";
    ModifyHeader: Boolean;
    Window: Dialog;
    ImageInstream: InStream;
    LineCount: Integer;
    GateEntryLbl: Label 'Gate Entry.';
    GateEntryNoLbl: Label '%1 %2', Comment = '%1 = Gate Entry Caption,%2 = Gate Entry No.';
    GateEntryUpdateLbl: Label 'Gate Entry %1 -> Posted Gate Entry %2.', Comment = '%1 = No., %2 =  PostedGateEntryHeader.No.';
    NothingToPostErr: Label 'There is nothing to post.';
    PostingLinesLbl: Label 'Posting Lines #2######\', Comment = '#2 = Open Dialog Window';
    FileName: Text;
    Record: Variant;
}
