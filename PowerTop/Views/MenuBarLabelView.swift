import SwiftUI

struct MenuBarLabelView: View {
    let monitor: PowerMonitor

    private var data: PowerData { monitor.currentData }
    private var showPower: Bool { monitor.showPowerInMenuBar }
    private var isDataAvailable: Bool { monitor.isDataAvailable }
    private var batteryPercent: Int { min(100, max(0, data.batteryPercent)) }

    private var batteryIconName: String {
        switch batteryPercent {
        case ...10: return "battery.0"
        case ...35: return "battery.25"
        case ...60: return "battery.50"
        case ...85: return "battery.75"
        default: return "battery.100"
        }
    }

    var body: some View {
        if !isDataAvailable {
            Image(systemName: "exclamationmark.triangle")
        } else {
            HStack(spacing: 4) {
                Image(systemName: data.effectiveIsOnAC ? "bolt.fill" : batteryIconName)
                    .frame(width: Self.statusIconWidth)

                Text("\(batteryPercent)%")
                    .monospacedDigit()
                    .frame(width: Self.batteryPercentTextWidth, alignment: .trailing)

                if showPower {
                    Text(data.menuBarPowerText)
                        .monospacedDigit()
                        .frame(
                            width: data.menuBarPowerShowsWarning
                                ? Self.warningPowerTextWidth
                                : Self.powerTextWidth,
                            alignment: .trailing
                        )
                }
            }
            .font(.system(size: 12, weight: .medium, design: .rounded))
        }
    }

    private static let statusIconWidth: CGFloat = 20
    private static let batteryPercentTextWidth: CGFloat = 34
    private static let powerTextWidth: CGFloat = 30
    private static let warningPowerTextWidth: CGFloat = 46
}
