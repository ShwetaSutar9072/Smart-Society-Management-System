package com.mycompany.smartsocietymca;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

/** Small helpers shared by the JSP pages. */
public final class Web {

    private Web() { }

    /** HTML-escape text before printing it (prevents XSS). */
    public static String h(Object o) {
        if (o == null) {
            return "";
        }
        String s = String.valueOf(o);
        StringBuilder sb = new StringBuilder(s.length() + 16);
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            switch (c) {
                case '&': sb.append("&amp;"); break;
                case '<': sb.append("&lt;"); break;
                case '>': sb.append("&gt;"); break;
                case '"': sb.append("&quot;"); break;
                case '\'': sb.append("&#39;"); break;
                default: sb.append(c);
            }
        }
        return sb.toString();
    }

    /** Trimmed request parameter, never null. */
    public static String param(HttpServletRequest req, String name) {
        String v = req.getParameter(name);
        return v == null ? "" : v.trim();
    }

    public static int toInt(String s, int fallback) {
        try {
            return Integer.parseInt(s.trim());
        } catch (Exception e) {
            return fallback;
        }
    }

    /** Message shown once on the next page (Post/Redirect/Get). type = success|danger|warning|info */
    public static void flash(HttpSession session, String type, String message) {
        session.setAttribute("flashType", type);
        session.setAttribute("flashMsg", message);
    }

    public static boolean isPost(HttpServletRequest req) {
        return "POST".equalsIgnoreCase(req.getMethod());
    }

    public static boolean validMobile(String s) {
        return s != null && s.matches("[0-9]{10}");
    }

    public static boolean validEmail(String s) {
        return s != null && s.matches("[^@\\s]+@[^@\\s]+\\.[^@\\s]+");
    }
}
