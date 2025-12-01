codeunit 60007 "SSD Quality Management"
{
    Permissions = tabledata "Item Ledger Entry"=rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnPostItemJnlLineOnAfterCopyDocumentFields', '', false, false)]
    local procedure OnPostItemJnlLineOnAfterCopyDocumentFields(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; PurchRcptHeader: Record "Purch. Rcpt. Header")
    var
        Item: Record Item;
    begin
        if PurchaseLine.IsCreditDocType()then exit;
        if PurchRcptHeader."No." = '' then exit;
        if not Item.Get(ItemJournalLine."Item No.")then exit;
        if Item.Get(ItemJournalLine."Item No.")then if not Item."Quality Required" then exit;
        ItemJournalLine."SSD Quality Status":=ItemJournalLine."SSD Quality Status"::Quarantine;
    end;
    procedure CreateReceiptQualityOrder(RecSourceType: Option Purchase, Manufacturing, , Calibration; var WarehouseReceiptLine: Record "Warehouse Receipt Line"; TemplateType: Option Receipt, Manufacturing, , Calibration; var OrderCount: Integer)
    var
        ItemSamplingTemp1: Record "Item Sampling Template";
        ReservationEntry: Record "Reservation Entry";
        // SSDAutomationSetup: Record "SSD Automation Setup";
        SSDQualityOrderHeader: Record "SSD Quality Order Header";
        SSDQualityOrderHeader2: Record "SSD Quality Order Header";
        QualityOrderNo: Code[20];
        SampleCount: Integer;
        NoTrackingLinesErr: label 'No Tracking Line found.';
    begin
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Max Sample Count");
        if WarehouseReceiptLine.FindSet()then repeat SSDQualityOrderHeader.Reset();
                SSDQualityOrderHeader.SetCurrentkey("Lot No.", "Source Document No.", "Source Doc. Line No.");
                SSDQualityOrderHeader.SetRange("Source Document No.", WarehouseReceiptLine."No.");
                SSDQualityOrderHeader.SetRange("Source Doc. Line No.", WarehouseReceiptLine."Line No.");
                if SSDQualityOrderHeader.FindFirst()then SSDQualityOrderHeader.Delete();
                ReservationEntry.Reset();
                ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
                ReservationEntry.SetRange("Source Type", WarehouseReceiptLine."Source Type");
                ReservationEntry.SetRange("Source Subtype", WarehouseReceiptLine."Source Subtype");
                ReservationEntry.SetRange("Source ID", WarehouseReceiptLine."Source No.");
                ReservationEntry.SetRange("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
                ReservationEntry.SetFilter("Item Tracking", '%1|%2|%3|%4', ReservationEntry."Item Tracking"::"Lot No.", ReservationEntry."Item Tracking"::"Lot and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial No.");
                if ReservationEntry.FindSet()then begin
                    OrderCount:=0;
                    repeat QualityOrderNo:='';
                        SSDQualityOrderHeader.Reset();
                        SSDQualityOrderHeader.SetCurrentkey("Lot No.", "Source Document No.", "Source Doc. Line No.");
                        SSDQualityOrderHeader.SetRange("Template Type", TemplateType);
                        SSDQualityOrderHeader.SetRange("Item No.", WarehouseReceiptLine."Item No.");
                        SSDQualityOrderHeader.SetRange("Lot No.", ReservationEntry."Lot No.");
                        SSDQualityOrderHeader.SetFilter("Source Document No.", '<>%1', WarehouseReceiptLine."No.");
                        if SSDQualityOrderHeader.FindFirst()then SSDQualityOrderHeader.Delete();
                        SSDQualityOrderHeader.Reset();
                        SSDQualityOrderHeader.SetCurrentkey("Lot No.", "Source Document No.", "Source Doc. Line No.");
                        SSDQualityOrderHeader.SetRange("Lot No.", ReservationEntry."Lot No.");
                        SSDQualityOrderHeader.SetRange("Source Document No.", WarehouseReceiptLine."No.");
                        SSDQualityOrderHeader.SetRange("Source Doc. Line No.", WarehouseReceiptLine."Line No.");
                        if SSDQualityOrderHeader.FindFirst()then begin
                            QualityOrderNo:=SSDQualityOrderHeader."No.";
                            SSDQualityOrderHeader."Lot Size":=SSDQualityOrderHeader."Lot Size" + ReservationEntry."Quantity (Base)";
                            SSDQualityOrderHeader.Modify();
                        end
                        else
                        begin
                            OrderCount+=1;
                            SSDQualityOrderHeader2.Init();
                            SSDQualityOrderHeader2."Template Type":=TemplateType;
                            SSDQualityOrderHeader2."Entry Source Type":=SSDQualityOrderHeader2."entry source type"::MRN;
                            SSDQualityOrderHeader2."Source Document No.":=WarehouseReceiptLine."No.";
                            SSDQualityOrderHeader2."Creation Date":=WorkDate();
                            SSDQualityOrderHeader2."Source Doc. Line No.":=WarehouseReceiptLine."Line No.";
                            SSDQualityOrderHeader2."Order No.":=WarehouseReceiptLine."Source No.";
                            SSDQualityOrderHeader2."Sampling Method":=SSDQualityOrderHeader2."sampling method"::"Complete Quantity";
                            SSDQualityOrderHeader2."Item No.":=WarehouseReceiptLine."Item No.";
                            SSDQualityOrderHeader2."Vendor Item Description":=WarehouseReceiptLine."Vendor Item Description";
                            SSDQualityOrderHeader2."Unit of Measure Code":=WarehouseReceiptLine."Unit of Measure Code";
                            SSDQualityOrderHeader2."Qty. per Unit of Measure":=WarehouseReceiptLine."Qty. per Unit of Measure";
                            SSDQualityOrderHeader2."Variant Code":=WarehouseReceiptLine."Variant Code";
                            SSDQualityOrderHeader2."Location Code":=WarehouseReceiptLine."Location Code";
                            SSDQualityOrderHeader2."Bin Code":=WarehouseReceiptLine."Bin Code";
                            SSDQualityOrderHeader2."Lot Size":=Abs(ReservationEntry."Quantity (Base)");
                            SSDQualityOrderHeader2."Lot No.":=CopyStr(ReservationEntry."Lot No.", 1, 20);
                            SSDQualityOrderHeader2."Time of Creation":=Time;
                            SSDQualityOrderHeader2."Automated Plant":=true;
                            SSDQualityOrderHeader2."Supplier Batch No.":=WarehouseReceiptLine."Supplier Batch No.";
                            ItemSamplingTemp1.Reset();
                            ItemSamplingTemp1.SetRange(ItemSamplingTemp1."Item Code", WarehouseReceiptLine."Item No.");
                            ItemSamplingTemp1.SetRange(ItemSamplingTemp1.Active, true);
                            if ItemSamplingTemp1.FindFirst()then SSDQualityOrderHeader2."Sampling Temp. No.":=ItemSamplingTemp1."Sampling Temp. No.";
                            SSDQualityOrderHeader2."No. Series":=SSDQualityOrderHeader2.GetNoSeries(true);
                            SSDQualityOrderHeader2."No.":='';
                            SSDQualityOrderHeader2."Entry User":=CopyStr(UserId, 1, 50);
                            SSDQualityOrderHeader2."Posting Date":=WorkDate();
                            SSDQualityOrderHeader2.Insert(true);
                            QualityOrderNo:=SSDQualityOrderHeader2."No.";
                        end;
                        SampleCount+=1;
                        InsertQualitySamples(QualityOrderNo, ReservationEntry."Item No.", ReservationEntry."Lot No.", ReservationEntry."Package No.", SampleCount, ReservationEntry.Quantity, ReservationEntry."Quantity (Base)");
                    until ReservationEntry.Next() = 0;
                end
                else
                    Error(NoTrackingLinesErr);
            //WarehouseReceiptLine."Send For Quality" := true;
            //WarehouseReceiptLine.Modify();
            until WarehouseReceiptLine.Next() = 0;
    end;
    procedure InsertQualityStatusForNonQualityItem(var WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        ReservationEntry: Record "Reservation Entry";
        SSDWMSSyncStatus: Record "SSD WMS Sync Status";
    begin
        ReservationEntry.Reset();
        ReservationEntry.SETCURRENTKEY("Source ID", "Source Ref. No.", "Source Type", "Source Subtype", "Source Batch Name", "Source Prod. Order Line", "Reservation Status", "Shipment Date", "Expected Receipt Date");
        ReservationEntry.SetRange("Source Type", WarehouseReceiptLine."Source Type");
        ReservationEntry.SetRange("Source Subtype", WarehouseReceiptLine."Source Subtype");
        ReservationEntry.SetRange("Source ID", WarehouseReceiptLine."Source No.");
        ReservationEntry.SetRange("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
        ReservationEntry.SetFilter("Item Tracking", '%1|%2|%3', ReservationEntry."Item Tracking"::"Package No.", ReservationEntry."Item Tracking"::"Lot and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial and Package No.");
        if ReservationEntry.FindSet()then repeat SSDWMSSyncStatus.Init();
                SSDWMSSyncStatus."Entry No.":=GetNextEntryNo();
                SSDWMSSyncStatus."Location Code":=WarehouseReceiptLine."Location Code";
                SSDWMSSyncStatus."Item No.":=WarehouseReceiptLine."Item No.";
                SSDWMSSyncStatus."Lot No.":=ReservationEntry."Lot No.";
                SSDWMSSyncStatus."Package No.":=ReservationEntry."Package No.";
                SSDWMSSyncStatus.Quantity:=ReservationEntry.Quantity;
                SSDWMSSyncStatus."Qty. (Base)":=ReservationEntry."Quantity (Base)";
                SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Passed;
                SSDWMSSyncStatus.Insert();
            until ReservationEntry.Next() = 0;
    end;
    procedure InsertQualityStatusFromQualityOrder(SSDQualityOrderHeader: Record "SSD Quality Order Header")
    var
        Item: Record Item;
        SSDQualitySamples: Record "SSD Quality Samples";
        SSDWMSSyncStatus: Record "SSD WMS Sync Status";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        if not Item.Get(SSDQualityOrderHeader."Item No.")then exit;
        Item.Get(SSDQualityOrderHeader."Item No.");
        if not SSDCommonFunctionAutomation.ItemPackageTracked(Item."No.")then exit;
        if SSDQualityOrderHeader."Template Type" = SSDQualityOrderHeader."Template Type"::Manufacturing then begin
            ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
            ItemLedgerEntry.SetLoadFields("Item No.", "Lot No.", "Package No.", "Entry Type", Quantity);
            ItemLedgerEntry.SetRange("Item No.", SSDQualityOrderHeader."Item No.");
            ItemLedgerEntry.SetRange("Lot No.", SSDQualityOrderHeader."Lot No.");
            ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
            if ItemLedgerEntry.FindSet()then repeat SSDWMSSyncStatus.Init();
                    SSDWMSSyncStatus."Entry No.":=GetNextEntryNo();
                    SSDWMSSyncStatus."Location Code":=SSDQualityOrderHeader."Location Code";
                    SSDWMSSyncStatus."Item No.":=SSDQualityOrderHeader."Item No.";
                    SSDWMSSyncStatus."Lot No.":=SSDQualityOrderHeader."Lot No.";
                    SSDWMSSyncStatus."Package No.":=ItemLedgerEntry."Package No.";
                    SSDWMSSyncStatus.Quantity:=ItemLedgerEntry.Quantity;
                    SSDWMSSyncStatus."Qty. (Base)":=ItemLedgerEntry.Quantity;
                    if SSDQualityOrderHeader."Decision For Quality Pass" = SSDQualityOrderHeader."Decision For Quality Pass"::Rejected then SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Failed
                    else
                        SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Passed;
                    SSDWMSSyncStatus.Insert();
                until ItemLedgerEntry.Next() = 0;
        end
        else
        begin
            SSDQualitySamples.Reset();
            SSDQualitySamples.SetRange("Document No.", SSDQualityOrderHeader."No.");
            if SSDQualitySamples.FindSet()then repeat SSDWMSSyncStatus.Init();
                    SSDWMSSyncStatus."Entry No.":=GetNextEntryNo();
                    SSDWMSSyncStatus."Location Code":=SSDQualityOrderHeader."Location Code";
                    SSDWMSSyncStatus."Item No.":=SSDQualityOrderHeader."Item No.";
                    SSDWMSSyncStatus."Lot No.":=SSDQualityOrderHeader."Lot No.";
                    SSDWMSSyncStatus."Package No.":=SSDQualitySamples."Package No.";
                    SSDWMSSyncStatus.Quantity:=SSDQualitySamples.Quantity;
                    SSDWMSSyncStatus."Qty. (Base)":=SSDQualitySamples."Qty (Base)";
                    if SSDQualityOrderHeader."Decision For Quality Pass" = SSDQualityOrderHeader."Decision For Quality Pass"::Rejected then SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Failed
                    else
                        SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Passed;
                    SSDWMSSyncStatus.Insert();
                until SSDQualitySamples.Next() = 0;
        end;
    end;
    procedure CreatePostedQualitySyncEntries(SSDPostedQualityOrderHdr: Record "SSD Posted Quality Order Hdr")
    var
        Item: Record Item;
        SSDWMSSyncStatus: Record "SSD WMS Sync Status";
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        if SSDPostedQualityOrderHdr."Template Type" <> SSDPostedQualityOrderHdr."Template Type"::Manufacturing then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(SSDPostedQualityOrderHdr."Location Code")then exit;
        if not Item.Get(SSDPostedQualityOrderHdr."Item No.")then exit;
        Item.Get(SSDPostedQualityOrderHdr."Item No.");
        if not SSDCommonFunctionAutomation.ItemPackageTracked(Item."No.")then exit;
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date");
        ItemLedgerEntry.SetLoadFields("Item No.", "Lot No.", "Package No.", "Entry Type", Quantity);
        ItemLedgerEntry.SetRange("Item No.", SSDPostedQualityOrderHdr."Item No.");
        ItemLedgerEntry.SetRange("Lot No.", SSDPostedQualityOrderHdr."Lot No.");
        ItemLedgerEntry.SetRange("Entry Type", ItemLedgerEntry."Entry Type"::Output);
        if ItemLedgerEntry.FindSet()then repeat SSDWMSSyncStatus.Init();
                SSDWMSSyncStatus."Entry No.":=GetNextEntryNo();
                SSDWMSSyncStatus."Location Code":=SSDPostedQualityOrderHdr."Location Code";
                SSDWMSSyncStatus."Item No.":=SSDPostedQualityOrderHdr."Item No.";
                SSDWMSSyncStatus."Lot No.":=SSDPostedQualityOrderHdr."Lot No.";
                SSDWMSSyncStatus."Package No.":=ItemLedgerEntry."Package No.";
                SSDWMSSyncStatus.Quantity:=ItemLedgerEntry.Quantity;
                SSDWMSSyncStatus."Qty. (Base)":=ItemLedgerEntry.Quantity;
                if SSDPostedQualityOrderHdr."Decision For Quality Pass" = SSDPostedQualityOrderHdr."Decision For Quality Pass"::Rejected then SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Failed
                else
                    SSDWMSSyncStatus.Status:=SSDWMSSyncStatus.Status::Passed;
                SSDWMSSyncStatus.Insert();
            until ItemLedgerEntry.Next() = 0;
    end;
    procedure SyncQualityStatus(LocationCode: Code[10]; PackageId: Code[50]; QualityStatus: Enum "SSD Quality Status"): Boolean var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        AccessToken: Text;
        RequestBody: Text;
        ResponseText: Text;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then exit;
        if LocationCode = '' then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(LocationCode)then exit;
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Quality URL");
        AccessToken:=SSDAutomationSyncManagement.GetAccessToken();
        RequestBody:=CreateQualityStatusJson(PackageId, QualityStatus);
        if(GuiAllowed) and (SSDAutomationSetup."Show Json")then Message(RequestBody);
        ResponseText:=SSDAutomationSyncManagement.PostAnzo(SSDAutomationSetup."Anzo Quality URL", RequestBody, AccessToken);
        JsonToken.ReadFrom(ResponseText);
        Clear(JsonObject);
        JsonObject:=JsonToken.AsObject();
        ResponseText:=GetJsonToken(JsonObject, 'status').AsValue().AsText();
        if ResponseText <> 'Success' then Error(ResponseText);
        exit(true);
    end;
    procedure CreateQualityStatusJson(PackageId: Code[50]; QualityStatus: Enum "SSD Quality Status")JsonText: Text var
        JSonObject: JsonObject;
        WMSStatus: Text[30];
        DayInt: Integer;
        MonthInt: Integer;
        YearInt: Integer;
        TransactionDate: Text;
    begin
        JsonText:='';
        DayInt:=Date2DMY(Today(), 1);
        MonthInt:=Date2DMY(Today(), 2);
        YearInt:=Date2DMY(Today(), 3);
        TransactionDate:=Format(YearInt);
        TransactionDate+='-';
        if StrLen(Format(MonthInt)) = 1 then TransactionDate+='0' + Format(MonthInt)
        else
            TransactionDate+=Format(MonthInt);
        TransactionDate+='-';
        if StrLen(Format(DayInt)) = 1 then TransactionDate+='0' + Format(DayInt)
        else
            TransactionDate+=Format(DayInt);
        JSonObject.Add('packageId', PackageId);
        ConvertQualityStatus(QualityStatus, WMSStatus);
        JSonObject.Add('status', WMSStatus);
        JSonObject.Add('statusDate', TransactionDate);
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    local procedure ConvertQualityStatus(QualityStatus: Enum "SSD Quality Status"; var WMSStatus: Text[30])
    begin
        case QualityStatus of QualityStatus::Quarantine: WMSStatus:=Format(QualityStatus);
        QualityStatus::Passed: WMSStatus:='Accepted';
        QualityStatus::Failed: WMSStatus:='Rejected';
        end;
    end;
    local procedure InsertQualitySamples(DocumentNo: Code[20]; ItemNo: Code[20]; LotNo: Code[50]; PackageNo: Code[50]; SequenceNo: Integer; Qty: Decimal; QtyBase: Decimal)
    var
        SSDQualitySamples: Record "SSD Quality Samples";
    begin
        SSDQualitySamples.Init();
        SSDQualitySamples."Document No.":=DocumentNo;
        SSDQualitySamples."Line No.":=GetNextLineNoSamples(DocumentNo);
        SSDQualitySamples."Item No.":=ItemNo;
        SSDQualitySamples."Lot No.":=LotNo;
        SSDQualitySamples."Package No.":=PackageNo;
        SSDQualitySamples."Sequence No.":=SequenceNo;
        SSDQualitySamples.Quantity:=Qty;
        SSDQualitySamples."Qty (Base)":=QtyBase;
        SSDQualitySamples.Insert();
    end;
    local procedure GetNextLineNoSamples(DocNo: Code[20])NextLineNo: Integer;
    var
        SSDQualitySamples: Record "SSD Quality Samples";
    begin
        SSDQualitySamples.Reset();
        SSDQualitySamples.SetRange("Document No.", DocNo);
        if SSDQualitySamples.FindLast()then NextLineNo:=SSDQualitySamples."Line No." + 10000
        else
            NextLineNo:=10000;
    end;
    local procedure GetNextEntryNo()NextEntryNo: Integer;
    var
        SSDWMSSyncStatus: Record "SSD WMS Sync Status";
    begin
        SSDWMSSyncStatus.Reset();
        if SSDWMSSyncStatus.FindLast()then NextEntryNo:=SSDWMSSyncStatus."Entry No." + 1
        else
            NextEntryNo:=1;
    end;
    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    SSDAutomationSyncManagement: Codeunit "SSD Automation Sync Mgt.";
}
