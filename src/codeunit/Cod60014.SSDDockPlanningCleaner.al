// codeunit 60014 "SSD Dock Planning Cleaner"
// {
//     trigger OnRun()
//     begin
//         Code();
//     end;
//     local procedure Code()
//     var
//         SSDDockPlanning: Record "SSD Dock Planning";
//         SSDDockPlanningHistory: Record "SSD Dock Planning History";
//     begin
//         SSDDockPlanning.SetRange("Planning Date", CalcDate('<-1D>', Today));
//         if SSDDockPlanning.FindSet()then repeat SSDDockPlanningHistory.Init();
//                 SSDDockPlanningHistory.TransferFields(SSDDockPlanning);
//                 SSDDockPlanningHistory."Deleted By":=CopyStr(UserId, 1, 50);
//                 SSDDockPlanningHistory.Insert();
//                 SSDDockPlanning.RemoveShipmentLink(SSDDockPlanning);
//                 SSDDockPlanning.Delete();
//             until SSDDockPlanning.Next() = 0;
//     end;
// }
