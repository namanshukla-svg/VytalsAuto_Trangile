codeunit 60004 "SSD Dock Management"
{
    #region Inward Dock Management
    procedure InsertDockLinesFromWhseRcptPlanning(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then exit;
        SSDDockLines.Init();
        SSDDockLines."Entry No.":=GetNextDocEntryNo();
        SSDDockLines."Location Code":=WarehouseReceiptHeader."Location Code";
        SSDDockLines."Dock No.":=WarehouseReceiptHeader."SSD Dock No.";
        SSDDockLines."Entry Type":=SSDDockLines."Entry Type"::Inward;
        SSDDockLines."Planning Date":=WarehouseReceiptHeader."Posting Date";
        SSDDockLines."Time Slot No.":=WarehouseReceiptHeader."SSD Slot No.";
        SSDDockLines."Time Slot Starting Time":=WarehouseReceiptHeader."SSD Slot Starting Time";
        SSDDockLines."Time Slot Ending Time":=WarehouseReceiptHeader."SSD Slot Ending Time";
        SSDDockLines.Status:=SSDDockLines.Status::Planned;
        SSDDockLines."Planning No.":=WarehouseReceiptHeader."No.";
        SSDDockLines.Insert();
    end;
    procedure RemoveDockLinesonReceiptReopen(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then exit;
        SSDDockLines.SetRange("Location Code", WarehouseReceiptHeader."Location Code");
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
        SSDDockLines.SetRange("Planning No.", WarehouseReceiptHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Planned);
        if SSDDockLines.FindSet()then SSDDockLines.DeleteAll();
    end;
    procedure UpdateDockInwardFromGatePosting(PostedGateEntryHeader: Record "Posted Gate Entry Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        PostedGateEntryLine: Record "Posted Gate Entry Line";
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(PostedGateEntryHeader."Location Code")then exit;
        if PostedGateEntryHeader."Entry Type" = PostedGateEntryHeader."Entry Type"::Inward then begin
            SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
            SSDDockLines.SetRange("Planning No.", PostedGateEntryHeader."SSD Planning No.");
            SSDDockLines.SetRange(Status, SSDDockLines.Status::Planned);
            if SSDDockLines.FindFirst()then begin
                SSDDockLines."Gate Entry No.":=PostedGateEntryHeader."No.";
                SSDDockLines."Gate Entry Date":=PostedGateEntryHeader."Posting Date";
                SSDDockLines."Planning No.":=PostedGateEntryHeader."SSD Planning No.";
                SSDDockLines."Driver Code":=PostedGateEntryHeader."SSD Driver Code";
                SSDDockLines."Driver Name":=PostedGateEntryHeader."SSD Driver Name";
                SSDDockLines."Vehicle No.":=PostedGateEntryHeader."SSD Vehicle No.";
                SSDDockLines.Status:=SSDDockLines.Status::Waiting;
                SSDDockLines.Modify(true);
            end;
        end;
        if PostedGateEntryHeader."Entry Type" = PostedGateEntryHeader."Entry Type"::Outward then begin
            //IG_DS  // WarehouseShipmentHeader.Get(PostedGateEntryHeader."SSD Planning No.");
            // WarehouseShipmentHeader."SSD Vehicle No." := PostedGateEntryHeader."SSD Vehicle No.";
            // WarehouseShipmentHeader.Modify();
            // UpdateOutwardGateIn(PostedGateEntryHeader, PostedGateEntryHeader."SSD Planning No.");
            // WarehouseShipmentHeader.Reset();
            // WarehouseShipmentHeader.SetRange("SSD Combined With", PostedGateEntryHeader."SSD Planning No.");
            // if WarehouseShipmentHeader.FindSet()then repeat UpdateOutwardGateIn(PostedGateEntryHeader, WarehouseShipmentHeader."No.");
            //         WarehouseShipmentHeader."SSD Vehicle No.":=PostedGateEntryHeader."SSD Vehicle No.";
            //         WarehouseShipmentHeader.Modify();
            //IG_DS   //     until WarehouseShipmentHeader.Next() = 0;
            PostedGateEntryLine.Reset();
            PostedGateEntryLine.SetRange("Entry Type", PostedGateEntryHeader."Entry Type");
            PostedGateEntryLine.SetRange("Gate Entry No.", PostedGateEntryHeader."No.");
            if PostedGateEntryLine.FindFirst()then repeat WarehouseShipmentHeader.Reset();
                    WarehouseShipmentHeader.SetRange("No.", PostedGateEntryLine."Planning No.");
                    if WarehouseShipmentHeader.FindFirst()then begin
                        UpdateOutwardGateIn(PostedGateEntryHeader, WarehouseShipmentHeader."No.");
                        WarehouseShipmentHeader."SSD Vehicle No.":=PostedGateEntryHeader."SSD Vehicle No.";
                        WarehouseShipmentHeader.Modify();
                    end;
                until PostedGateEntryLine.Next() = 0;
        end;
    end;
    local procedure UpdateOutwardGateIn(PostedGateEntryHeader: Record "Posted Gate Entry Header"; PlanningNo: Code[20])
    var
        SSDDockLines: Record "SSD Dock Lines";
        NoEntriesExistsErr: Label 'No open planning lines found for Shipment No. %1', Comment = '%1 Warehouse Shipment No.';
    begin
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange("Planning No.", PlanningNo);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Planned);
        if SSDDockLines.FindFirst()then begin
            SSDDockLines."Gate Entry No.":=PostedGateEntryHeader."No.";
            SSDDockLines."Gate Entry Date":=PostedGateEntryHeader."Posting Date";
            //SSDDockLines."Planning No." := PostedGateEntryHeader."SSD Planning No.";
            SSDDockLines."Driver Code":=PostedGateEntryHeader."SSD Driver Code";
            SSDDockLines."Driver Name":=PostedGateEntryHeader."SSD Driver Name";
            SSDDockLines."Vehicle No.":=PostedGateEntryHeader."SSD Vehicle No.";
            SSDDockLines.Status:=SSDDockLines.Status::Waiting;
            SSDDockLines.Modify(true);
        end
        else
            Error(NoEntriesExistsErr, PlanningNo);
    end;
    procedure ProcessReceiptDockIn(SSDDock: Record "SSD Dock"; QRText: Text)
    var
        SSDDockLines: Record "SSD Dock Lines";
        SSDDockLines2: Record "SSD Dock Lines";
        DockSuccessTxt: Label 'Vehicle %1 Dock-in successful.', Comment = '%1 = Vehicle No.';
        VehicleNotExistsTxt: Label 'Vehicle %1 does not have open Dock-In Entry', Comment = '%1 = Vehicle No.';
    begin
        if QRText = '' then exit;
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetFilter("Vehicle No.", '<>%1', QRText);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if SSDDockLines.FindFirst()then Error(DockBusyErr, SSDDock.Code, SSDDockLines."Vehicle No.");
        SSDDockLines.Reset();
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetRange("Vehicle No.", QRText);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Waiting);
        if not SSDDockLines.FindFirst()then Error(VehicleNotExistsTxt, QRText)
        else
        begin
            SSDDockLines2.Get(SSDDockLines."Entry No.");
            SSDDockLines2.Status:=SSDDockLines2.Status::"In-Process";
            SSDDockLines2.Modify(true);
            Message(DockSuccessTxt, QRText);
        end;
        SetDockInProcessStatus(SSDDock);
    end;
    procedure CheckInwardDockLines(WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
        PlanningLineExistsTxt: Label 'Warehouse Receipt cannot be deleted because inward planning line exists';
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then exit;
        SSDDockLines.SetRange("Location Code", WarehouseReceiptHeader."Location Code");
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
        SSDDockLines.SetRange("Planning No.", WarehouseReceiptHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Planned);
        if not SSDDockLines.IsEmpty()then Error(PlanningLineExistsTxt);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnCodeOnAfterGetWhseRcptHeader', '', false, false)]
    local procedure SSDOnCodeOnAfterGetWhseRcptHeader(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
        DockLineNotExistsErr: Label 'Dock Line with Status In-Process not found for Warehouse Receipt %1', Comment = '%1 = Warehouse Receipt No.';
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then exit;
        SSDDockLines.SetRange("Planning No.", WarehouseReceiptHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if SSDDockLines.IsEmpty then Error(DockLineNotExistsErr, WarehouseReceiptHeader."No.");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Receipt", 'OnAfterCode', '', false, false)]
    local procedure SSDOnOnAfterCode(var WarehouseReceiptHeader: Record "Warehouse Receipt Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
        SSDDockLines2: Record "SSD Dock Lines";
        DockLineNotExistsErr: Label 'Dock Line with Status In-Process not found for Warehouse Receipt %1', Comment = '%1 = Warehouse Receipt No.';
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseReceiptHeader."Location Code")then exit;
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
        SSDDockLines.SetRange("Planning No.", WarehouseReceiptHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if not SSDDockLines.FindFirst()then Error(DockLineNotExistsErr, WarehouseReceiptHeader."No.")
        else
        begin
            SSDDockLines2.Get(SSDDockLines."Entry No.");
            SSDDockLines2.Status:=SSDDockLines2.Status::Completed;
            SSDDockLines2.Modify();
        end;
    end;
    procedure ProcessInwardDockOut(SSDDock: Record "SSD Dock"; QRText: Text)
    var
        SSDDockLines: Record "SSD Dock Lines";
        SSDDockLines2: Record "SSD Dock Lines";
        DockSuccessTxt: Label 'Vehicle %1 Dock-out successful.', Comment = '%1 = Vehicle No.';
        VehicleNoExistsTxt: Label 'Vehicle %1 does not have In-Process Dock-In Entry', Comment = '%1 = Vehicle No.';
    begin
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetRange("Vehicle No.", QRText);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Inward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Completed);
        if not SSDDockLines.FindFirst()then Message(VehicleNoExistsTxt, QRText)
        else
        begin
            SSDDockLines2.Get(SSDDockLines."Entry No.");
            SSDDockLines2.Status:=SSDDockLines2.Status::"Dock Out";
            SSDDockLines2.Modify(true);
            Message(DockSuccessTxt, QRText);
        end;
        SetDockWaitingStatus(SSDDock);
    end;
    #endregion 
    #region Outward Dock Management
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", 'OnAfterReleaseWarehouseShipment', '', false, false)]
    local procedure SSDOnAfterReleaseWarehouseShipment(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        InsertDockLinesFromWhseShipmentPlanning(WarehouseShipmentHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", 'OnBeforeReopen', '', false, false)]
    local procedure SSDOnBeforeReopen(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        GateEntryHeader: Record "Gate Entry Header";
        GateEntryExistErr: Label 'Open Gate Entry Inward %1 is linked with Warehouse Shipment. Remove Planning No. from Gate Entry', Comment = '%1 Gate Entry No.';
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        GateEntryHeader.SetRange("Entry Type", GateEntryHeader."Entry Type"::Outward);
        GateEntryHeader.SetRange("SSD Planning No.", WarehouseShipmentHeader."No.");
        if GateEntryHeader.FindFirst()then Error(GateEntryExistErr, GateEntryHeader."No.");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Shipment Release", 'OnAfterReopen', '', false, false)]
    local procedure SSDOnAfterReopen(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        RemoveDockLinesonShipmentReopen(WarehouseShipmentHeader);
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnCodeOnAfterGetWhseShptHeader', '', false, false)]
    local procedure SSDOnCodeOnAfterGetWhseShptHeader(var WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
        DockLineNotExistsErr: Label 'Dock Line with Status In-Process not found for Warehouse Shipment %1', Comment = '%1 = Warehouse Shipment No.';
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange("Planning No.", WarehouseShipmentHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if SSDDockLines.IsEmpty()then Error(DockLineNotExistsErr, WarehouseShipmentHeader."No.");
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Whse.-Post Shipment", 'OnAfterPostWhseShipment', '', false, false)]
    local procedure SSDOnAfterPostWhseShipment(var WarehouseShipmentHeader: Record "Warehouse Shipment Header"; SuppressCommit: Boolean)
    var
        SSDDockLines: Record "SSD Dock Lines";
        SSDDockLines2: Record "SSD Dock Lines";
        WarehouseShipmentHeader2: Record "Warehouse Shipment Header";
        DockLineNotExistsErr: Label 'Dock Line with Status In-Process not found for Warehouse Shipment %1', Comment = '%1 = Warehouse Shipment No.';
    begin
        if SuppressCommit then exit;
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        WarehouseShipmentHeader2.Reset();
        if WarehouseShipmentHeader2.Get(WarehouseShipmentHeader."No.")then exit;
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange("Planning No.", WarehouseShipmentHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if not SSDDockLines.FindFirst()then Error(DockLineNotExistsErr, WarehouseShipmentHeader."No.")
        else
        begin
            SSDDockLines2.Get(SSDDockLines."Entry No.");
            SSDDockLines2.Status:=SSDDockLines2.Status::Completed;
            SSDDockLines2.Modify();
        end;
    end;
    procedure InsertDockLinesFromWhseShipmentPlanning(WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        SSDDockLines.Init();
        SSDDockLines."Entry No.":=GetNextDocEntryNo();
        SSDDockLines."Location Code":=WarehouseShipmentHeader."Location Code";
        SSDDockLines."Dock No.":=WarehouseShipmentHeader."SSD Dock No.";
        SSDDockLines."Entry Type":=SSDDockLines."Entry Type"::Outward;
        SSDDockLines."Planning Date":=WarehouseShipmentHeader."Posting Date";
        SSDDockLines."Time Slot No.":=WarehouseShipmentHeader."SSD Slot No.";
        SSDDockLines."Time Slot Starting Time":=WarehouseShipmentHeader."SSD Slot Starting Time";
        SSDDockLines."Time Slot Ending Time":=WarehouseShipmentHeader."SSD Slot Ending Time";
        SSDDockLines.Status:=SSDDockLines.Status::Planned;
        SSDDockLines."Planning No.":=WarehouseShipmentHeader."No.";
        SSDDockLines.Insert();
    end;
    procedure RemoveDockLinesonShipmentReopen(WarehouseShipmentHeader: Record "Warehouse Shipment Header")
    var
        SSDDockLines: Record "SSD Dock Lines";
    begin
        if not SSDCommonFunctionAutomation.IsLocationAutomated(WarehouseShipmentHeader."Location Code")then exit;
        SSDDockLines.SetRange("Location Code", WarehouseShipmentHeader."Location Code");
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange("Planning No.", WarehouseShipmentHeader."No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Planned);
        if SSDDockLines.FindSet()then SSDDockLines.DeleteAll();
    end;
    procedure ProcessShipmentDockIn(SSDDock: Record "SSD Dock"; QRText: Text)
    var
        SSDDockLines: Record "SSD Dock Lines";
        SSDDockLines2: Record "SSD Dock Lines";
        DockSuccessTxt: Label 'Vehicle %1 Dock-in successful.', Comment = '%1 = Vehicle No.';
        VehicleNoExistsTxt: Label 'Vehicle %1 does not have open Dock-In Entry', Comment = '%1 = Vehicle No.';
    begin
        if QRText = '' then exit;
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetFilter("Vehicle No.", '<>%1', QRText);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if SSDDockLines.FindFirst()then Error(DockBusyErr, SSDDock.Code, SSDDockLines."Vehicle No.");
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetRange("Vehicle No.", QRText);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Waiting);
        if SSDDockLines.FindSet()then begin
            repeat SSDDockLines2.Get(SSDDockLines."Entry No.");
                SSDDockLines2.Status:=SSDDockLines2.Status::"In-Process";
                SSDDockLines2.Modify(true);
            until SSDDockLines.Next() = 0;
            Message(DockSuccessTxt, QRText);
        end
        else
            Message(VehicleNoExistsTxt, QRText);
        SetDockInProcessStatus(SSDDock);
    end;
    procedure ProcessShipmentDockOut(SSDDock: Record "SSD Dock"; QRText: Text)
    var
        SSDDockLines: Record "SSD Dock Lines";
        SSDDockLines2: Record "SSD Dock Lines";
        DockSuccessTxt: Label 'Vehicle %1 Dock-out successful.', Comment = '%1 = Vehicle No.';
        PendingShipmentErr: Label 'Shipment %1 is not posted. Dock out cannot be done.', Comment = '%1 = Warehouse Shipment No.';
        VehicleNoExistsTxt: Label 'Vehicle %1 does not have In-Process Dock-In Entry', Comment = '%1 = Vehicle No.';
    begin
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetRange("Vehicle No.", QRText);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if SSDDockLines.FindFirst()then Error(PendingShipmentErr, SSDDockLines."Planning No.");
        SSDDockLines.SetRange(Status, SSDDockLines.Status::Completed);
        if SSDDockLines.FindSet()then begin
            repeat SSDDockLines2.Get(SSDDockLines."Entry No.");
                SSDDockLines2.Status:=SSDDockLines2.Status::"Dock Out";
                SSDDockLines2.Modify(true);
            until SSDDockLines.Next() = 0;
            Message(DockSuccessTxt, QRText);
        end
        else
            Error(VehicleNoExistsTxt, QRText);
        SetDockWaitingStatus(SSDDock);
    end;
    procedure ProcessVehicleLoading(SSDDock: Record "SSD Dock"; QRText: Text)
    var
        ReservationEntry: Record "Reservation Entry";
        SSDShipmentPackageBuffer: Record "SSD Vehicle Loading Buffer";
        AlreadyLoadedErr: Label 'Package %1 is already loaded on vehicle', Comment = '%1 = Package No.';
        PackageNotFoundErr: Label 'Package No. %1 not mapped to Dock %2', Comment = '%1 = Package No. %2 Dock No.';
    begin
        if QRText = '' then exit;
        SSDShipmentPackageBuffer.Reset();
        SSDShipmentPackageBuffer.SetRange("Location Code", SSDDock."Location Code");
        SSDShipmentPackageBuffer.SetRange("Dock No.", SSDDock.Code);
        SSDShipmentPackageBuffer.SetRange("Package No.", QRText);
        if SSDShipmentPackageBuffer.IsEmpty then Error(PackageNotFoundErr, QRText, SSDDock.Code);
        if SSDShipmentPackageBuffer.FindFirst()then begin
            if SSDShipmentPackageBuffer."Vehicle Loaded" then Error(AlreadyLoadedErr, QRText);
            ReservationEntry.Get(SSDShipmentPackageBuffer."Reservation Entry No.");
            ReservationEntry."SSD Vehicle Loaded":=true;
            ReservationEntry.Modify();
            SSDShipmentPackageBuffer."Vehicle Loaded":=true;
            SSDShipmentPackageBuffer.Modify();
        end;
    end;
    procedure FillPackageBuffer(SSDDock: Record "SSD Dock")
    var
        ReservationEntry: Record "Reservation Entry";
        SSDDockLines: Record "SSD Dock Lines";
        SSDShipmentPackageBuffer: Record "SSD Vehicle Loading Buffer";
        WarehouseShipmentLine: Record "Warehouse Shipment Line";
    begin
        SSDShipmentPackageBuffer.Reset();
        if SSDShipmentPackageBuffer.FindSet()then SSDShipmentPackageBuffer.DeleteAll();
        SSDDockLines.SetRange("Location Code", SSDDock."Location Code");
        SSDDockLines.SetRange("Dock No.", SSDDock.Code);
        SSDDockLines.SetRange("Entry Type", SSDDockLines."Entry Type"::Outward);
        SSDDockLines.SetRange(Status, SSDDockLines.Status::"In-Process");
        if SSDDockLines.FindSet()then repeat WarehouseShipmentLine.SetRange("No.", SSDDockLines."Planning No.");
                WarehouseShipmentLine.SetFilter("Qty. to Ship", '<>%1', 0);
                if WarehouseShipmentLine.FindSet()then repeat ReservationEntry.Reset();
                        case WarehouseShipmentLine."Source Document" of WarehouseShipmentLine."Source Document"::"Sales Order": ReservationEntry.SetRange("Source Type", Database::"Sales Line");
                        WarehouseShipmentLine."Source Document"::"Outbound Transfer": ReservationEntry.SetRange("Source Type", Database::"Transfer Line");
                        WarehouseShipmentLine."Source Document"::"Purchase Return Order": ReservationEntry.SetRange("Source Type", Database::"Purchase Line");
                        end;
                        ReservationEntry.SetRange("Source ID", WarehouseShipmentLine."Source No.");
                        ReservationEntry.SetRange("Source Ref. No.", WarehouseShipmentLine."Source Line No.");
                        ReservationEntry.SetFilter("Item Tracking", '<>%1', ReservationEntry."Item Tracking"::None);
                        if ReservationEntry.FindSet()then repeat SSDShipmentPackageBuffer.Init();
                                SSDShipmentPackageBuffer."Entry No.":=GetNextBufferEntryNo();
                                SSDShipmentPackageBuffer."Location Code":=SSDDock."Location Code";
                                SSDShipmentPackageBuffer."Dock No.":=SSDDock.Code;
                                SSDShipmentPackageBuffer."Shipment No.":=WarehouseShipmentLine."No.";
                                SSDShipmentPackageBuffer."Shipment Line No.":=WarehouseShipmentLine."Line No.";
                                SSDShipmentPackageBuffer."Reservation Entry No.":=ReservationEntry."Entry No.";
                                SSDShipmentPackageBuffer."Package No.":=ReservationEntry."Package No.";
                                SSDShipmentPackageBuffer."Vehicle Loaded":=ReservationEntry."SSD Vehicle Loaded";
                                SSDShipmentPackageBuffer.Insert();
                            until ReservationEntry.Next() = 0;
                    until WarehouseShipmentLine.Next() = 0;
            until SSDDockLines.Next() = 0;
    end;
    procedure GetPackageBufferCounts(DockNo: Code[20]; var TotalCount: Integer; var LoadedCount: Integer; var RemainingCount: Integer)
    var
        SSDShipmentPackageBuffer: Record "SSD Vehicle Loading Buffer";
    begin
        SSDShipmentPackageBuffer.Reset();
        SSDShipmentPackageBuffer.SetRange("Dock No.", DockNo);
        TotalCount:=SSDShipmentPackageBuffer.Count;
        SSDShipmentPackageBuffer.SetRange("Vehicle Loaded", true);
        LoadedCount:=SSDShipmentPackageBuffer.Count;
        SSDShipmentPackageBuffer.SetRange("Vehicle Loaded", false);
        RemainingCount:=SSDShipmentPackageBuffer.Count;
    end;
    #endregion 
    procedure CalculateDockPlan()
    var
        WarehouseSetup: Record "Warehouse Setup";
        WarehouseShipmentHeader: Record "Warehouse Shipment Header";
        WarehouseShipmentLines: Record "Warehouse Shipment Line";
        EndDate: Date;
        StartDate: Date;
        ShipmentCount: Integer;
        LinesExistsMsg: Label 'Dock Planning Lines Exists. If you continue, existing lines will be deleted and new planning lines will be created. Do you wish to continue';
        SuccessMsg: Label '%1 Shipments Planned', Comment = '%1 = Count of Warehouse Shipments Planned ';
        WarehouseSetupMissingErr: Label 'Warehouse Setup for Pallet Planning Days is not defined.';
    begin
        WarehouseSetup.Get();
        if Format(WarehouseSetup."SSD Pallet Planning Days") = '' then Error(WarehouseSetupMissingErr);
        ShipmentCount:=0;
        StartDate:=Today;
        EndDate:=CalcDate(WarehouseSetup."SSD Pallet Planning Days", StartDate);
        SSDDockPlanning.Reset();
        if not SSDDockPlanning.IsEmpty then if not confirm(LinesExistsMsg, false)then exit;
        SSDDockPlanning.DeleteAll();
        Commit();
        WarehouseShipmentHeader.SetRange(Status, WarehouseShipmentHeader.Status::Released);
        WarehouseShipmentHeader.SetRange("Location Code", GetAutomatedLocation());
        WarehouseShipmentHeader.SetRange("Posting Date", StartDate, EndDate);
        if WarehouseShipmentHeader.FindSet()then repeat WarehouseShipmentHeader.TestField("SSD Dock No.");
                WarehouseShipmentHeader.TestField("SSD Slot No.");
                ShipmentCount+=1;
                WarehouseShipmentLines.SetRange("No.", WarehouseShipmentHeader."No.");
                if WarehouseShipmentLines.FindSet()then repeat if not WarehouseShipmentLines."Pick Planned" then begin
                            InsertDockPlanningLines(WarehouseShipmentHeader."Location Code", WarehouseShipmentHeader."SSD Dock No.", WarehouseShipmentHeader."SSD Slot No.", WarehouseShipmentHeader."Posting Date", WarehouseShipmentLines."Item No.", WarehouseShipmentLines."Qty. (Base)", WarehouseShipmentHeader."No.");
                            WarehouseShipmentLines."Pick Planned":=true;
                            WarehouseShipmentLines.Modify();
                        end;
                    until WarehouseShipmentLines.Next() = 0;
            until WarehouseShipmentHeader.Next() = 0;
        Message(SuccessMsg, ShipmentCount);
    end;
    procedure CallDockPickWave(LocationCode: Code[20]; DockCode: Code[20]; PickDate: Date; TimeSlot: Code[20])
    var
        SSDDock: Record "SSD Dock";
        SSDDockPlanning2: Record "SSD Dock Planning";
        SSDDockPlanning3: Record "SSD Dock Planning";
        SSDDockTimeSlots: Record "SSD Dock Time Slots";
        SSDProcessPickWave: Codeunit "SSD Process Pick Wave";
        SuccessStatus: Boolean;
        NoDockPlanningLinesErr: Label 'There are no dock planning lines';
        ErrorTxt: Text;
    begin
        SSDDock.Get(LocationCode, DockCode);
        if PickDate = 0D then Error('Blank Pick Date');
        if TimeSlot = '' then Error('Blank Time Slot');
        if not SSDDockTimeSlots.Get(SSDDock."Location Code", SSDDock.Code, TimeSlot)then Error('Time Slot not found');
        SSDDockPlanning2.Reset();
        SSDDockPlanning2.SetRange("Location Code", SSDDock."Location Code");
        SSDDockPlanning2.SetRange("Dock No.", SSDDock.Code);
        SSDDockPlanning2.SetRange("Time Slot No.", TimeSlot);
        SSDDockPlanning2.SetRange("Planning Date", PickDate);
        SSDDockPlanning2.SetRange("Record Synced", false);
        if SSDDockPlanning2.IsEmpty then Error(NoDockPlanningLinesErr);
        if SSDDockPlanning2.FindSet()then repeat Clear(SSDProcessPickWave);
                SSDProcessPickWave.SyncPickWave(SSDDockPlanning2, SuccessStatus, ErrorTxt);
                if not SuccessStatus then Error(ErrorTxt)
                else
                begin
                    SSDDockPlanning3.Get(SSDDockPlanning2."Location Code", SSDDockPlanning2."Dock No.", SSDDockPlanning2."Time Slot No.", SSDDockPlanning2."Planning Date", SSDDockPlanning2."Item No.");
                    SSDDockPlanning3."Record Synced":=true;
                    SSDDockPlanning3.Modify();
                end;
            until SSDDockPlanning2.Next() = 0;
    end;
    local procedure InsertDockPlanningLines(LocationCode: Code[10]; DockNo: Code[20]; TimeSlotNo: Code[20]; PlanningDate: Date; ItemNo: Code[20]; Quantity: Decimal; ShipmentNo: Code[20])
    var
        PickWaveSyncErr: Label 'Pick Wave is already synced. Retrieve inventory manually from WMS. Shipment %1 Item %2 cannot be synced', Comment = '%1 Shipment No. %2 Item No.';
    begin
        SSDDockPlanning.Reset();
        if SSDDockPlanning.Get(LocationCode, DockNo, TimeSlotNo, PlanningDate, ItemNo)then begin
            if SSDDockPlanning."Record Synced" then Error(PickWaveSyncErr, ShipmentNo, ItemNo);
            SSDDockPlanning.Validate(Quantity, SSDDockPlanning.Quantity + Quantity);
            SSDDockPlanning.Modify();
        end
        else
        begin
            SSDDockPlanning.Init();
            SSDDockPlanning.Validate("Location Code", LocationCode);
            SSDDockPlanning."Dock No.":=DockNo;
            SSDDockPlanning."Time Slot No.":=TimeSlotNo;
            SSDDockPlanning.Validate("Planning Date", PlanningDate);
            SSDDockPlanning.Validate("Item No.", ItemNo);
            SSDDockPlanning.Validate(Quantity, Quantity);
            SSDDockPlanning.Insert();
        end;
    end;
    local procedure GetNextDocEntryNo()NextEntryNo: Integer var
        SSDDockLines: Record "SSD Dock Lines";
    begin
        SSDDockLines.Reset();
        if SSDDockLines.FindLast()then NextEntryNo:=SSDDockLines."Entry No." + 1
        else
            NextEntryNo:=1;
    end;
    local procedure SetDockWaitingStatus(var SSDDock: Record "SSD Dock")
    begin
        if SSDDock.Status = SSDDock.Status::Waiting then exit;
        SSDDock.Status:=SSDDock.Status::Waiting;
        SSDDock.Modify(true);
    end;
    local procedure SetDockInProcessStatus(var SSDDock: Record "SSD Dock")
    begin
        if SSDDock.Status = SSDDock.Status::"In-Process" then exit;
        SSDDock.Status:=SSDDock.Status::"In-Process";
        SSDDock.Modify(true);
    end;
    local procedure GetAutomatedLocation(): Code[10]var
        Location: Record Location;
    begin
        Location.SetRange("SSD Automated Plant", true);
        if not Location.FindFirst()then Error('Automation not active for any location')
        else
            exit(Location.Code);
    end;
    local procedure GetNextBufferEntryNo()NextEntryNo: Integer;
    var
        SSDShipmentPackageBuffer: Record "SSD Vehicle Loading Buffer";
    begin
        SSDShipmentPackageBuffer.Reset();
        if SSDShipmentPackageBuffer.FindLast()then NextEntryNo:=SSDShipmentPackageBuffer."Entry No." + 1
        else
            NextEntryNo:=1;
    end;
    var SSDDockPlanning: Record "SSD Dock Planning";
    SSDCommonFunctionAutomation: Codeunit "SSD Common Function Automation";
    DockBusyErr: Label 'Dock %1 is busy with Vehicle %2', Comment = '%1 = Dock No. %2 = Vehicle No.';
}
