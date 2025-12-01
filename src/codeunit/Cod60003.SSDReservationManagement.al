codeunit 60003 "SSD Reservation Management"
{
    Permissions = tabledata "Item Ledger Entry"=rm;

    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry', '', false, false)]
    local procedure SSDOnRegisterChangeOnChangeTypeInsertOnBeforeInsertReservEntry(var TrackingSpecification: Record "Tracking Specification"; var OldTrackingSpecification: Record "Tracking Specification"; var NewTrackingSpecification: Record "Tracking Specification"; FormRunMode: Option)
    begin
        ModifyRun:=false;
        SSDGrossWeight:=NewTrackingSpecification."SSD Gross Weight";
        SSDEntrySynced:=NewTrackingSpecification."SSD Entry Synced";
        SSDQualityRequired:=NewTrackingSpecification."SSD Quality Required";
        SSDVehicleLoaded:=NewTrackingSpecification."SSD Vehicle Loaded";
    // FromPackage := NewTrackingSpecification."From Package";
    // ToPackage := NewTrackingSpecification."To Package";
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterEntriesAreIdentical', '', false, false)]
    local procedure SSDOnAfterEntriesAreIdentical(ReservEntry1: Record "Reservation Entry"; ReservEntry2: Record "Reservation Entry"; var IdenticalArray: array[2]of Boolean)
    begin
        IdenticalArray[2]:=(ReservEntry1."SSD Gross Weight" = ReservEntry2."SSD Gross Weight") and (ReservEntry1."SSD Entry Synced" = ReservEntry2."SSD Entry Synced") and (ReservEntry1."SSD Quality Required" = ReservEntry2."SSD Quality Required") and (ReservEntry1."SSD Vehicle Loaded" = ReservEntry2."SSD Vehicle Loaded"); // and
    // (ReservEntry1."From Package" = ReservEntry2."From Package") and (ReservEntry1."To Package" = ReservEntry2."To Package");
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterCopyTrackingSpec', '', false, false)]
    local procedure SSDOnAfterCopyTrackingSpec(var SourceTrackingSpec: Record "Tracking Specification"; var DestTrkgSpec: Record "Tracking Specification")
    begin
        if ModifyRun = false then begin
            SourceTrackingSpec."SSD Gross Weight":=DestTrkgSpec."SSD Gross Weight";
            SourceTrackingSpec."SSD Entry Synced":=DestTrkgSpec."SSD Entry Synced";
            SourceTrackingSpec."SSD Quality Required":=DestTrkgSpec."SSD Quality Required";
            SourceTrackingSpec."SSD Vehicle Loaded":=DestTrkgSpec."SSD Vehicle Loaded";
        // SourceTrackingSpec."From Package" := DestTrkgSpec."From Package";
        // SourceTrackingSpec."To Package" := DestTrkgSpec."To Package";
        end
        else
        begin
            DestTrkgSpec."SSD Gross Weight":=SourceTrackingSpec."SSD Gross Weight";
            DestTrkgSpec."SSD Entry Synced":=SourceTrackingSpec."SSD Entry Synced";
            DestTrkgSpec."SSD Quality Required":=SourceTrackingSpec."SSD Quality Required";
            DestTrkgSpec."SSD Vehicle Loaded":=SourceTrackingSpec."SSD Vehicle Loaded";
        // DestTrkgSpec."From Package" := SourceTrackingSpec."From Package";
        // DestTrkgSpec."To Package" := SourceTrackingSpec."To Package";
        end;
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterMoveFields', '', false, false)]
    local procedure SSDOnAfterMoveFields(var TrkgSpec: Record "Tracking Specification"; var ReservEntry: Record "Reservation Entry")
    begin
        ReservEntry."SSD Gross Weight":=TrkgSpec."SSD Gross Weight";
        ReservEntry."SSD Entry Synced":=TrkgSpec."SSD Entry Synced";
        ReservEntry."SSD Quality Required":=TrkgSpec."SSD Quality Required";
        ReservEntry."SSD Vehicle Loaded":=TrkgSpec."SSD Vehicle Loaded";
    // ReservEntry."From Package" := TrkgSpec."From Package";
    // ReservEntry."To Package" := TrkgSpec."To Package";
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAfterAssignNewTrackingNo', '', false, false)]
    local procedure SSDOnAfterAssignNewTrackingNo(var TrkgSpec: Record "Tracking Specification"; xTrkgSpec: Record "Tracking Specification"; FieldID: Integer; var SourceTrackingSpecification: Record "Tracking Specification")
    var
        Item: Record Item;
    begin
        if not Item.Get(TrkgSpec."Item No.")then exit;
        Item.Get(TrkgSpec."Item No.");
        if Format(Item."Expiration Calculation") = '' then exit;
        if TrkgSpec."Expiration Date" <> 0D then exit;
        TrkgSpec.Validate("Expiration Date", CalcDate(Item."Expiration Calculation", Today));
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnAssignTrackingNoOnAfterCalcQtyToCreate', '', false, false)]
    local procedure SSDOnAssignTrackingNoOnAfterCalcQtyToCreate(var TrackingSpecification: Record "Tracking Specification"; var SourceTrackingSpecification: Record "Tracking Specification"; var TotalTrackingSpecification: Record "Tracking Specification"; var QtyToCreate: Decimal; FieldID: Integer)
    var
        Item: Record Item;
    begin
        if(FieldID <> TrackingSpecification.FieldNo("Package No.")) and (FieldID <> TrackingSpecification.FieldNo("Lot No."))then exit;
        Item.Get(TrackingSpecification."Item No.");
        if Item."Pack Size" <= 0 then exit;
        if QtyToCreate > Item."Pack Size" then QtyToCreate:=Item."Pack Size";
    end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnBeforeAssignPackageNo', '', false, false)]
    local procedure SSDOnBeforeAssignPackageNo(var TrackingSpecification: Record "Tracking Specification")
    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        PackageTrackingErr: Label 'You cannot use Package Tracking for Item %1', Comment = '%1 Item No.';
    begin
        if TrackingSpecification."Item No." = '' then exit;
        Item.Get(TrackingSpecification."Item No.");
        ItemTrackingCode.Get(Item."Item Tracking Code");
        if not ItemTrackingCode."Package Specific Tracking" then Error(PackageTrackingErr, Item."No.");
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnCheckPackageNo', '', false, false)]
    local procedure SSDOnCheckPackageNo(TrackingSpecification: Record "Tracking Specification"; PackageNo: Code[50])
    var
        Item: Record Item;
        ItemTrackingCode: Record "Item Tracking Code";
        PackageTrackingErr: Label 'You cannot use Package Tracking for Item %1', Comment = '%1 Item No.';
    begin
        if TrackingSpecification."Item No." = '' then exit;
        if PackageNo = '' then exit;
        Item.Get(TrackingSpecification."Item No.");
        ItemTrackingCode.Get(Item."Item Tracking Code");
        if not ItemTrackingCode."Package Specific Tracking" then Error(PackageTrackingErr, Item."No.");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnAfterSetDates', '', false, false)]
    local procedure SSDOnAfterSetDates(var ReservationEntry: Record "Reservation Entry")
    begin
        ReservationEntry."SSD Gross Weight":=SSDGrossWeight;
        ReservationEntry."SSD Entry Synced":=SSDEntrySynced;
        ReservationEntry."SSD Quality Required":=SSDQualityRequired;
        ReservationEntry."SSD Vehicle Loaded":=SSDVehicleLoaded;
    // ReservationEntry."From Package" := FromPackage;
    // ReservationEntry."To Package" := ToPackage;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Create Reserv. Entry", 'OnCreateReservEntryExtraFields', '', false, false)]
    local procedure SSDOnCreateReservEntryExtraFields(var InsertReservEntry: Record "Reservation Entry"; OldTrackingSpecification: Record "Tracking Specification"; NewTrackingSpecification: Record "Tracking Specification")
    begin
        InsertReservEntry."SSD Gross Weight":=NewTrackingSpecification."SSD Gross Weight";
        InsertReservEntry."SSD Entry Synced":=NewTrackingSpecification."SSD Entry Synced";
        InsertReservEntry."SSD Quality Required":=NewTrackingSpecification."SSD Quality Required";
        InsertReservEntry."SSD Vehicle Loaded":=NewTrackingSpecification."SSD Vehicle Loaded";
    // InsertReservEntry."From Package" := NewTrackingSpecification."From Package";
    // InsertReservEntry."To Package" := NewTrackingSpecification."To Package";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertSetupTempSplitItemJnlLine', '', false, false)]
    local procedure SSDOnBeforeInsertSetupTempSplitItemJnlLine(var TempTrackingSpecification: Record "Tracking Specification" temporary; var TempItemJournalLine: Record "Item Journal Line" temporary; var PostItemJnlLine: Boolean; var ItemJournalLine2: Record "Item Journal Line"; SignFactor: Integer; FloatingFactor: Decimal)
    begin
        TempItemJournalLine."SSD Gross Weight":=TempTrackingSpecification."SSD Gross Weight";
        TempItemJournalLine."SSD Entry Synced":=TempTrackingSpecification."SSD Entry Synced";
        TempItemJournalLine."SSD Quality Required":=TempTrackingSpecification."SSD Quality Required";
        TempItemJournalLine."SSD Vehicle Loaded":=TempTrackingSpecification."SSD Vehicle Loaded";
    // TempItemJournalLine."From Package" := TempTrackingSpecification."From Package";
    // TempItemJournalLine."To Package" := TempTrackingSpecification."To Package";
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnAfterInitItemLedgEntry', '', false, false)]
    local procedure SSDOnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer)
    begin
        NewItemLedgEntry."SSD Gross Weight":=ItemJournalLine."SSD Gross Weight";
        NewItemLedgEntry."SSD Entry Synced":=ItemJournalLine."SSD Entry Synced";
        NewItemLedgEntry."SSD Quality Status":=ItemJournalLine."SSD Quality Status";
        NewItemLedgEntry."SSD Quality Required":=ItemJournalLine."SSD Quality Required";
        NewItemLedgEntry."SSD Vehicle Loaded":=ItemJournalLine."SSD Vehicle Loaded";
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnBeforeOnDelete', '', false, false)]
    local procedure SSDOnBeforeOnDelete(var TrackingSpecification: Record "Tracking Specification"; xTrackingSpecification: Record "Tracking Specification"; var IsHandled: Boolean)
    begin
        TrackingSpecification.TestField("SSD Entry Synced", false);
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterInitExpirationDate', '', false, false)]
    local procedure SSDOnAfterInitExpirationDate(var TrackingSpecification: Record "Tracking Specification")
    var
        Item: Record Item;
    begin
        if not Item.Get(TrackingSpecification."Item No.")then exit;
        Item.Get(TrackingSpecification."Item No.");
        if Format(Item."Expiration Calculation") = '' then exit;
        if TrackingSpecification."Expiration Date" <> 0D then exit;
        TrackingSpecification.Validate("Expiration Date", CalcDate(Item."Expiration Calculation", Today));
    end;
    [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnValidateQuantityBaseOnBeforeCheckItemTrackingChange', '', false, false)]
    local procedure SSDOnValidateQuantityBaseOnBeforeCheckItemTrackingChange(var TrackingSpecification: Record "Tracking Specification"; CallingFieldNo: Integer; var IsHandled: Boolean)
    var
        Item: Record Item;
    begin
        if TrackingSpecification."SSD Gross Weight" <> 0 then exit;
        if TrackingSpecification."Item No." = '' then exit;
        if TrackingSpecification."Quantity (Base)" = 0 then TrackingSpecification."SSD Gross Weight":=0
        else
        begin
            Item.Get(TrackingSpecification."Item No.");
            TrackingSpecification.Validate("SSD Gross Weight", Item."Gross Weight" * TrackingSpecification."Quantity (Base)");
        end;
    end;
    //SSD_Sunil
    // [EventSubscriber(ObjectType::Table, Database::"Tracking Specification", 'OnAfterValidateEvent', 'Quantity (Base)', false, false)]
    // local procedure TrackingSpecificatioOnAfterValidateEventLotNo(var Rec: Record "Tracking Specification")
    // var
    //     Item: Record Item;
    // Begin
    //     if Rec."SSD Gross Weight" <> 0 then
    //         exit;
    //     if Rec."Item No." = '' then
    //         exit;
    //     if Rec."Quantity (Base)" = 0 then
    //         Rec."SSD Gross Weight" := 0
    //     else begin
    //         Item.Get(Rec."Item No.");
    //         Rec.Validate("SSD Gross Weight", Item."Gross Weight" * rec."Quantity (Base)");
    //     end;
    // end;
    //SSD_Sunil
    [EventSubscriber(ObjectType::Table, Database::"Reservation Entry", 'OnAfterCopyTrackingFromTrackingSpec', '', false, false)]
    local procedure SSDOnAfterCopyTrackingFromTrackingSpec(var ReservationEntry: Record "Reservation Entry"; TrackingSpecification: Record "Tracking Specification")
    begin
        //if TrackingSpecification.Positive then
        ReservationEntry."SSD Gross Weight":=TrackingSpecification."SSD Gross Weight";
    // ReservationEntry."From Package" := TrackingSpecification."From Package";
    // ReservationEntry."To Package" := TrackingSpecification."To Package";
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Tracking Data Collection", 'OnTransferItemLedgToTempRecOnBeforeInsert', '', false, false)]
    // local procedure SSDOnTransferItemLedgToTempRecOnBeforeInsert(var TempGlobalReservEntry: Record "Reservation Entry" temporary; ItemLedgerEntry: Record "Item Ledger Entry")
    // begin
    //     TempGlobalReservEntry.Quantity := ItemLedgerEntry.Quantity;
    // end;
    [EventSubscriber(ObjectType::Page, Page::"Item Tracking Lines", 'OnInsertRecordOnBeforeTempItemTrackLineInsert', '', false, false)]
    local procedure SSDOnInsertRecordOnBeforeTempItemTrackLineInsert(var TempTrackingSpecificationInsert: Record "Tracking Specification" temporary; var TempTrackingSpecification: Record "Tracking Specification" temporary)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
    begin
        if TempTrackingSpecificationInsert."Source Type" <> Database::"Sales Line" then exit;
        if TempTrackingSpecificationInsert."Source Subtype" <> TempTrackingSpecificationInsert."Source Subtype"::"1" then exit;
        if TempTrackingSpecificationInsert."Package No." = '' then exit;
        ItemLedgerEntry.SetCurrentKey("Item No.", Open, "Variant Code", Positive, "Lot No.", "Serial No.", "Package No.");
        ItemLedgerEntry.SetLoadFields("Item No.", "Lot No.", "Package No.", "Remaining Quantity");
        ItemLedgerEntry.SetRange("Item No.", TempTrackingSpecificationInsert."Item No.");
        ItemLedgerEntry.SetRange("Lot No.", TempTrackingSpecificationInsert."Lot No.");
        ItemLedgerEntry.SetRange("Package No.", TempTrackingSpecificationInsert."Package No.");
        if ItemLedgerEntry.FindSet()then begin
            ItemLedgerEntry.CalcSums("Remaining Quantity");
            TempTrackingSpecificationInsert.Validate("Quantity (Base)", ItemLedgerEntry."Remaining Quantity");
            TempTrackingSpecification.Validate("Quantity (Base)", ItemLedgerEntry."Remaining Quantity");
        end;
    end;
    procedure SyncWarehouseReceipt(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        WarehouseReceiptLine: Record "Warehouse Receipt Line";
    begin
        //if WarehouseReceiptHeader."SSD Material Type" <> WarehouseReceiptHeader."SSD Material Type"::"Non-Bulk" then
        //exit;
        WarehouseReceiptHeader.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then exit;
        WarehouseReceiptLine.Reset();
        WarehouseReceiptLine.SetRange("No.", WarehouseReceiptHeader."No.");
        if WarehouseReceiptLine.FindSet()then repeat if SSDCommonFunctionAutomation.ItemPackageTracked(WarehouseReceiptLine."Item No.")then SyncWarehouseReceiptLine(WarehouseReceiptLine);
            until WarehouseReceiptLine.Next() = 0;
    end;
    local procedure SyncWarehouseReceiptLine(WarehouseReceiptLine: Record "Warehouse Receipt Line")
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        SuccessStatus: Boolean;
        ErrorTxt: Text;
    begin
        ReservationEntry.Reset();
        case WarehouseReceiptLine."Source Document" of WarehouseReceiptLine."Source Document"::"Purchase Order": ReservationEntry.SetRange("Source Type", Database::"Purchase Line");
        WarehouseReceiptLine."Source Document"::"Inbound Transfer": ReservationEntry.SetRange("Source Type", Database::"Transfer Line");
        WarehouseReceiptLine."Source Document"::"Sales Return Order": ReservationEntry.SetRange("Source Type", Database::"Sales Line");
        end;
        ReservationEntry.SetRange("Source ID", WarehouseReceiptLine."Source No.");
        ReservationEntry.SetRange("Source Ref. No.", WarehouseReceiptLine."Source Line No.");
        ReservationEntry.SetRange("SSD Entry Synced", false);
        ReservationEntry.SetFilter("Item Tracking", '%1|%2|%3', ReservationEntry."Item Tracking"::"Package No.", ReservationEntry."Item Tracking"::"Lot and Package No.", ReservationEntry."Item Tracking"::"Lot and Serial and Package No.");
        if ReservationEntry.FindSet()then repeat Clear(SSDAnzoSyncManagement);
                SuccessStatus:=false;
                ErrorTxt:='';
                if SSDCommonFunctionAutomation.IsItemNonBulk(ReservationEntry."Item No.")then begin
                    SSDWReceiptManagement.SyncWarehouseReceiptLine(WarehouseReceiptLine, ReservationEntry, SuccessStatus, ErrorTxt);
                    if not SuccessStatus then Error(ErrorTxt)
                    else
                    begin
                        ReservationEntry2.Get(ReservationEntry."Entry No.", ReservationEntry.Positive);
                        ReservationEntry2."SSD Entry Synced":=true;
                        ReservationEntry2.Modify();
                    end;
                end;
            until ReservationEntry.Next() = 0;
    end;
    procedure SyncProductionOutput(ProductionOrder: Record "Production Order")
    var
        ProdOrderLine: Record "Prod. Order Line";
    begin
        ProductionOrder.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ProductionOrder."Location Code")then exit;
        ProdOrderLine.Reset();
        ProdOrderLine.SetRange(Status, ProductionOrder.Status);
        ProdOrderLine.SetRange("Prod. Order No.", ProductionOrder."No.");
        if ProdOrderLine.FindSet()then repeat if SSDCommonFunctionAutomation.ItemPackageTracked(ProdOrderLine."Item No.")then SyncProductionOrderLine(ProdOrderLine);
            until ProdOrderLine.Next() = 0;
        Commit();
        Clear(SSDSyncProductionAction);
        SSDSyncProductionAction.SyncProductionOutput(ProductionOrder);
    end;
    local procedure SyncProductionOrderLine(ProdOrderLine: Record "Prod. Order Line")
    var
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        SuccessStatus: Boolean;
        SuccessMsg: Label 'Records Synced Successfully';
        ErrorTxt: Text;
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetCurrentKey("Source Type", "Source Subtype", "Source ID", "Source Batch Name", "Source Prod. Order Line", "Source Ref. No.");
        ReservationEntry.SetRange("Source Type", Database::"Prod. Order Line");
        ReservationEntry.SetRange("Source Subtype", ReservationEntry."Source Subtype"::"3");
        ReservationEntry.SetRange("Source ID", ProdOrderLine."Prod. Order No.");
        ReservationEntry.SetRange("Source Prod. Order Line", ProdOrderLine."Line No.");
        ReservationEntry.SetRange("SSD Entry Synced", false);
        if ReservationEntry.FindSet()then repeat Clear(SSDAnzoSyncManagement);
                SuccessStatus:=false;
                ErrorTxt:='';
                if SSDCommonFunctionAutomation.IsItemNonBulk(ReservationEntry."Item No.")then begin
                    Clear(SSDSyncProduction);
                    SSDSyncProduction.SyncProductionOrderOutput(ProdOrderLine, ReservationEntry, SuccessStatus, ErrorTxt);
                    if not SuccessStatus then Error(ErrorTxt)
                    else
                    begin
                        ReservationEntry2.Get(ReservationEntry."Entry No.", ReservationEntry.Positive);
                        ReservationEntry2."SSD Entry Synced":=true;
                        ReservationEntry2.Modify();
                    end;
                end;
            until ReservationEntry.Next() = 0;
        Message(SuccessMsg);
    end;
    //SSD_Sunil
    procedure SyncitemLedgerEntry(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
        ReservationEntry2: Record "Reservation Entry";
        SuccessStatus: Boolean;
        ErrorTxt: Text;
    begin
        ReservationEntry.Reset();
        ReservationEntry.SetRange("Source Type", Database::"Item Ledger Entry");
        ReservationEntry.SetRange(Positive, true);
        //ReservationEntry.SetRange("Source ID", WarehouseReceiptLine."Source No.");
        ReservationEntry.SetRange("Source Ref. No.", ItemLedgerEntry."Entry No.");
        ReservationEntry.SetRange("SSD Entry Synced", false);
        if ReservationEntry.FindSet()then repeat Clear(SSDAnzoSyncManagement);
                SuccessStatus:=false;
                ErrorTxt:='';
                if SSDCommonFunctionAutomation.IsItemNonBulk(ReservationEntry."Item No.")then begin
                    SyncItemLedgerEntry(ItemLedgerEntry, ReservationEntry, SuccessStatus, ErrorTxt);
                    if not SuccessStatus then Error(ErrorTxt)
                    else
                    begin
                        ReservationEntry2.Get(ReservationEntry."Entry No.", ReservationEntry.Positive);
                        ReservationEntry2."SSD Entry Synced":=true;
                        ReservationEntry2.Modify();
                        ItemLedgEntry.Get(ItemLedgerEntry."Entry No.");
                        ItemLedgEntry."SSD Entry Synced":=true;
                        ItemLedgEntry.Modify();
                    end;
                end;
            until ReservationEntry.Next() = 0;
    end;
    procedure SyncitemLedgerEntry2(ItemLedgerEntry: Record "Item Ledger Entry")
    var
        ItemLedgEntry: Record "Item Ledger Entry";
        ReservationEntry: Record "Reservation Entry";
        SuccessStatus: Boolean;
        ErrorTxt: Text;
    begin
        ItemLedgEntry.Reset();
        ItemLedgEntry.SetRange("Entry No.", ItemLedgerEntry."Entry No.");
        ItemLedgEntry.SetRange(Positive, true);
        ItemLedgEntry.SetRange("SSD Entry Synced", false);
        if ItemLedgEntry.FindFirst()then begin
            Clear(SSDAnzoSyncManagement);
            SuccessStatus:=false;
            ErrorTxt:='';
            if SSDCommonFunctionAutomation.IsItemNonBulk(ItemLedgEntry."Item No.")then begin
                SyncItemLedgerEntry(ItemLedgEntry, ReservationEntry, SuccessStatus, ErrorTxt);
                if not SuccessStatus then Error(ErrorTxt)
                else
                begin
                    ItemLedgEntry."SSD Entry Synced":=true;
                    ItemLedgEntry.Modify();
                    Commit();
                end;
            end;
        //until ReservationEntry.Next() = 0;
        end;
    end;
    //SSD_Sunil
    //SSD_Sunil
    procedure SyncItemLedgerEntry(ItemLedgerEntry: Record "Item Ledger Entry"; ReservationEntry: Record "Reservation Entry"; var APIStatus: Boolean; var ErrorText: Text)
    var
        JsonObject: JsonObject;
        JsonToken: JsonToken;
        AccessToken: Text;
        RequestBody: Text;
        ResponseText: Text;
    begin
        WarehouseSetup.Get();
        if WarehouseSetup."SSD Internal Instance" then begin
            APIStatus:=true;
            exit;
        end;
        ItemLedgerEntry.TestField("Location Code");
        if not SSDCommonFunctionAutomation.IsLocationAutomated(ItemLedgerEntry."Location Code")then exit;
        SSDAutomationSetup.Get();
        SSDAutomationSetup.TestField("Anzo Receipt URL");
        AccessToken:=SSDAutomationSyncMgt.GetAccessToken();
        RequestBody:=CreateItemLedgerEntryJson(ItemLedgerEntry);
        if SSDAutomationSetup."Show Json" then Message(RequestBody);
        ResponseText:=SSDAutomationSyncMgt.PostAnzo(SSDAutomationSetup."Anzo Receipt URL", RequestBody, AccessToken);
        JsonToken.ReadFrom(ResponseText);
        Clear(JsonObject);
        JsonObject:=JsonToken.AsObject();
        ResponseText:=GetJsonToken(JsonObject, 'status').AsValue().AsText();
        if ResponseText = 'Success' then begin
            APIStatus:=true;
            ErrorText:='';
        end
        else
            Error(ResponseText);
    end;
    local procedure CreateItemLedgerEntryJson(ItemLedgerEntry: Record "Item Ledger Entry")JsonText: Text var
        //WarehouseReceiptHeader: Record "Warehouse Receipt Header";
        Item: Record Item;
        JSonObject: JsonObject;
    begin
        // WarehouseReceiptHeader.Get(WarehouseReceiptLine."No.");
        Item.Get(ItemLedgerEntry."Item No.");
        Item.TestField("SSD Storage Type");
        JsonText:='';
        JSonObject.Add('receiptNo', ItemLedgerEntry."Document No.");
        JSonObject.Add('receiptDate', ItemLedgerEntry."Posting Date");
        JSonObject.Add('itemNo', ItemLedgerEntry."Item No.");
        JSonObject.Add('itemName', Item.Description);
        JSonObject.Add('quantity', ItemLedgerEntry.Quantity);
        JSonObject.Add('unitofMeasureCode', Item."Base Unit of Measure");
        JSonObject.Add('packageId', ItemLedgerEntry."Package No.");
        JSonObject.Add('lotnumber', ItemLedgerEntry."Lot No.");
        JSonObject.Add('docknumber', 'D-1');
        JSonObject.Add('grossWeight', (Item."Gross Weight" * ItemLedgerEntry.Quantity));
        JSonObject.Add('expiryDate', ItemLedgerEntry."Expiration Date");
        JSonObject.Add('palletTypePreference', Item."SSD Pallet Type");
        JSonObject.Add('storageType', Format(Item."SSD Storage Type"));
        JSonObject.WriteTo(JsonText);
        JsonText:='[' + JsonText + ']';
    end;
    local procedure GetJsonToken(JsonObject: JsonObject; TokenKey: text)JsonToken: JsonToken;
    begin
        if not JsonObject.Get(TokenKey, JsonToken)then Error('Could not find a token with key %1', TokenKey);
    end;
    var SSDAutomationSetup: Record "SSD Automation Setup";
    WarehouseSetup: Record "Warehouse Setup";
    SSDAnzoSyncManagement: Codeunit "SSD Automation Sync Mgt.";
    SSDWReceiptManagement: Codeunit "SSD Warehouse Receipt Mgt.";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    SSDAutomationSyncMgt: Codeunit "SSD Automation Sync Mgt.";
    SSDSyncProduction: Codeunit "SSD Sync Production";
    SSDSyncProductionAction: Codeunit "SSD Sync Production Actions";
    ModifyRun: Boolean;
    SSDEntrySynced: Boolean;
    SSDQualityRequired: Boolean;
    SSDVehicleLoaded: Boolean;
    SSDGrossWeight: Decimal;
    FromPackage: Code[20];
    ToPackage: Code[20];
}
