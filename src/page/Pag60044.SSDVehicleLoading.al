// page 60044 "SSD Vehicle Loading"
// {
//     ApplicationArea = All;
//     Caption = 'Vehicle Loading';
//     PageType = Card;
//     SourceTable = "SSD Dock";
//     UsageCategory = None;

//     layout
//     {
//         area(Content)
//         {
//             group(General)
//             {
//                 Caption = 'General';

//                 field(QRText; QRText)
//                 {
//                     ApplicationArea = All;
//                     Caption = 'Package QR Code';
//                     ExtendedDatatype = Barcode;
//                     ToolTip = 'Specifies the value of the Package QR value field.';

//                     trigger OnValidate()
//                     begin
//                         SSDDockManagement.ProcessVehicleLoading(Rec, QRText);
//                         QRText:='';
//                         UpdateControls();
//                         CurrPage.Update();
//                     end;
//                 }
//             }
//             group(Statistics)
//             {
//                 fixed(Control123)
//                 {
//                     group(TotalCountG)
//                     {
//                         Caption = 'Total Packages';

//                         field(TotalCount; TotalCount)
//                         {
//                             Caption = 'Total Package';
//                             ShowCaption = false;
//                             ToolTip = 'Specifies the value of the Total Packages field.';
//                         }
//                     }
//                     group(LoadedCountG)
//                     {
//                         Caption = 'Packages Loaded';

//                         field(LoadedCount; LoadedCount)
//                         {
//                             Caption = 'Packages Loaded';
//                             ShowCaption = false;
//                             ToolTip = 'Specifies the value of the Packages Loaded field.';
//                         }
//                     }
//                     group(RemainingCountG)
//                     {
//                         Caption = 'Remaining Packages';

//                         field(RemainingCount; RemainingCount)
//                         {
//                             Caption = 'Remaining Packages';
//                             ShowCaption = false;
//                             ToolTip = 'Specifies the value of the Remaining Packages field.';
//                         }
//                     }
//                 }
//             }
//             group(Packages)
//             {
//                 part("SSD Vehicle Loading Buffer"; "SSD Vehicle Loading Buffer")
//                 {
//                     Caption = 'Packages';
//                     ApplicationArea = All;
//                     SubPageLink = "Dock No."=field(Code);
//                 }
//             }
//         }
//     }
//     trigger OnOpenPage()
//     begin
//         UpdateControls();
//     end;
//     local procedure UpdateControls()
//     begin
//         SSDDockManagement.GetPackageBufferCounts(Rec.Code, TotalCount, LoadedCount, RemainingCount);
//     end;
//     var SSDDockManagement: Codeunit "SSD Dock Management";
//     LoadedCount: Integer;
//     RemainingCount: Integer;
//     TotalCount: Integer;
//     QRText: Text;
// }
