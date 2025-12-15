package com.atharva;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HelloController {

    @GetMapping("/")
    public String home() {
        return "<h1>Welcome to Atharva's Java Spring Boot App 🚀</h1>"
             + "<p>Deployed via Jenkins CI/CD + Nginx + EC2</p>"
             + "<p>Try visiting <a href='/day'>/day</a> for a special message!</p>";
    }

    @GetMapping("/day")
    public String dayMessage() {
        String day = java.time.LocalDate.now().getDayOfWeek().toString();

        switch (day) {
            case "MONDAY":
                return "<h2>Start of the week — stay focused and crush it! 💪</h2>";
            case "TUESDAY":
                return "<h2>Keep going strong — it’s only Tuesday!</h2>";
            case "WEDNESDAY":
                return "<h2>Midweek motivation — you’re halfway there! 🏁</h2>";
            case "THURSDAY":
                return "<h2>Almost Friday — keep the energy up!</h2>";
            case "FRIDAY":
                return "<h2>Weekend vibes incoming! 🎉</h2>";
            case "SATURDAY":
                return "<h2>Relax, recharge, and enjoy your weekend! 🌞</h2>";
            case "SUNDAY":
                return "<h2>Sunday rest day — prepare for greatness ahead! 😌</h2>";
            default:
                return "<h2>Have a great day!</h2>";
        }
    }

    @GetMapping("/info")
    public String info() {
        return "<h2>Address: Kalyan West, Maharashtra, India</h2>"
             + "<p>Deployment Successful ✅</p>";
    }
}
