package com.atharva;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.time.Month;

@RestController
public class HelloController {

    @GetMapping("/")
    public String home() {
        return "<h1>Welcome to Atharva’s Cloud Storage🌍</h1>"
             + "<p>Try visiting these links:</p>"
             + "<ul>"
             + "<li><a href='/days'>View all days of the week</a></li>"
             + "<li><a href='/months'>View all 12 months</a></li>"
             + "<li><a href='/month'>View current month</a></li>"
             + "</ul>";
    }

    // 🗓️ Endpoint to show all 12 months
    @GetMapping("/months")
    public String showMonths() {
        StringBuilder builder = new StringBuilder("<h2>All 12 Months of the Year:</h2><ul>");
        for (Month month : Month.values()) {
            builder.append("<li>").append(month.toString()).append("</li>");
        }
        builder.append("</ul>");
        return builder.toString();
    }

    // 🗓️ Endpoint to show current month
    @GetMapping("/month")
    public String currentMonth() {
        Month month = java.time.LocalDate.now().getMonth();
        return "<h3>Current month: " + month + " 🌼</h3>";
    }

    // 🗓️ Endpoint to show all days (reuse from before)
    @GetMapping("/days")
    public String showDays() {
        String[] days = {"MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"};
        StringBuilder builder = new StringBuilder("<h2>Days of the Week:</h2><ul>");
        for (String day : days) {
            builder.append("<li>").append(day).append("</li>");
        }
        builder.append("</ul>");
        return builder.toString();
    }
}
