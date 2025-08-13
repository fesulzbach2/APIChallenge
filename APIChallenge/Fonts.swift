//
//  Fonys.swift
//  APIChallenge
//
//  Created by Isadora Ferreira Guerra on 13/08/25.
//

import SwiftUI

/// Centralized typography styles matching your Figma spec (SF Pro / system)
public struct Fonts {
    public enum Style {
        // Large Title
        case largeTitleRegular          // 34 / 41, tracking: 0.4, regular
        case largeTitleEmphasized       // 34 / 41, tracking: 0.4, bold

        // Title 1
        case title1Regular              // 28 / 34, tracking: 0.4, regular
        case title1Emphasized           // 28 / 34, tracking: 0.4, bold

        // Title 2
        case title2Regular              // 22 / 28, tracking: -0.3, regular
        case title2Emphasized           // 22 / 28, tracking: -0.3, bold

        // Title 3
        case title3Regular              // 20 / 25, tracking: -0.4, regular
        case title3Emphasized           // 20 / 25, tracking: -0.4, semibold

        // Headline (Apple uses semibold as the default weight)
        case headline                   // 17 / 22, tracking: -0.4, semibold

        // Body
        case bodyRegular                // 17 / 22, tracking: -0.4, regular
        case bodyEmphasized             // 17 / 22, tracking: -0.4, semibold

        // Callout
        case calloutRegular             // 16 / 21, tracking: -0.3, regular
        case calloutEmphasized          // 16 / 21, tracking: -0.3, semibold

        // Subheadline
        case subheadlineRegular         // 15 / 20, tracking: -0.2, regular
        case subheadlineEmphasized      // 15 / 20, tracking: -0.2, semibold

        // Footnote
        case footnoteRegular            // 13 / 18, tracking: -0.1, regular
        case footnoteEmphasized         // 13 / 18, tracking: -0.1, semibold

        // Caption 1
        case caption1Regular            // 12 / 16, tracking: 0.0, regular
        case caption1Emphasized         // 12 / 16, tracking: 0.0, medium

        // Caption 2
        case caption2Regular            // 11 / 13, tracking: 0.1, regular
        case caption2Emphasized         // 11 / 13, tracking: 0.1, semibold
    }

    /// Returns the configured `Font`, lineHeight and tracking for a style.
    public static func specs(for style: Style) -> (font: Font, size: CGFloat, lineHeight: CGFloat, tracking: CGFloat) {
        switch style {
        // Large Title
        case .largeTitleRegular:     return (.system(size: 34, weight: .regular), 34, 41,  0.4)
        case .largeTitleEmphasized:  return (.system(size: 34, weight: .bold),    34, 41,  0.4)

        // Title 1
        case .title1Regular:         return (.system(size: 28, weight: .regular), 28, 34,  0.4)
        case .title1Emphasized:      return (.system(size: 28, weight: .bold),    28, 34,  0.4)

        // Title 2
        case .title2Regular:         return (.system(size: 22, weight: .regular), 22, 28, -0.3)
        case .title2Emphasized:      return (.system(size: 22, weight: .bold),    22, 28, -0.3)

        // Title 3
        case .title3Regular:         return (.system(size: 20, weight: .regular), 20, 25, -0.4)
        case .title3Emphasized:      return (.system(size: 20, weight: .semibold),20, 25, -0.4)

        // Headline
        case .headline:              return (.system(size: 17, weight: .semibold),17, 22, -0.4)

        // Body
        case .bodyRegular:           return (.system(size: 17, weight: .regular), 17, 22, -0.4)
        case .bodyEmphasized:        return (.system(size: 17, weight: .semibold),17, 22, -0.4)

        // Callout
        case .calloutRegular:        return (.system(size: 16, weight: .regular), 16, 21, -0.3)
        case .calloutEmphasized:     return (.system(size: 16, weight: .semibold),16, 21, -0.3)

        // Subheadline
        case .subheadlineRegular:    return (.system(size: 15, weight: .regular), 15, 20, -0.2)
        case .subheadlineEmphasized: return (.system(size: 15, weight: .semibold),15, 20, -0.2)

        // Footnote
        case .footnoteRegular:       return (.system(size: 13, weight: .regular), 13, 18, -0.1)
        case .footnoteEmphasized:    return (.system(size: 13, weight: .semibold),13, 18, -0.1)

        // Caption 1
        case .caption1Regular:       return (.system(size: 12, weight: .regular), 12, 16,  0.0)
        case .caption1Emphasized:    return (.system(size: 12, weight: .medium),  12, 16,  0.0)

        // Caption 2
        case .caption2Regular:       return (.system(size: 11, weight: .regular), 11, 13,  0.1)
        case .caption2Emphasized:    return (.system(size: 11, weight: .semibold),11, 13,  0.1)
        }
    }
}

/// ViewModifier that applies font, tracking (kerning) and a fixed line-height.
/// Note: SwiftUI doesn’t expose a strict “line-height” setter; the common
/// approach is to set `lineSpacing = lineHeight - fontSize` and force
/// `.multilineTextAlignment` with `.fixedSize` to better respect the target.
private struct TypographyModifier: ViewModifier {
    let style: Fonts.Style

    func body(content: Content) -> some View {
        let spec = Fonts.specs(for: style)
        let extraLineSpacing = max(0, spec.lineHeight - spec.size)

        content
            .font(spec.font)
            .kerning(spec.tracking)
            .lineSpacing(extraLineSpacing)
            .fixedSize(horizontal: false, vertical: true)
    }
}

public extension View {
    /// Apply one of the Figma-matched text styles.
    func typography(_ style: Fonts.Style) -> some View {
        modifier(TypographyModifier(style: style))
    }
}

