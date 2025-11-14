# SNS Topic para alarmas
resource "aws_sns_topic" "alerts" {
  name = "${var.project}-alerts"
  tags = local.common_tags
}

# Alarma simple - Backend 5XX errors
resource "aws_cloudwatch_metric_alarm" "backend_errors" {
  alarm_name          = "${var.project}-backend-5xx"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "HTTPCode_Target_5XX_Count"
  namespace           = "AWS/ApplicationELB"
  period              = 60
  statistic           = "Sum"
  threshold           = 5
  alarm_description   = "Alarma cuando backend tiene +5 errores 5XX"

  dimensions = {
    TargetGroup  = aws_lb_target_group.backend_tg.arn_suffix
    LoadBalancer = aws_lb.alb.arn_suffix
  }

  alarm_actions = [aws_sns_topic.alerts.arn]
  tags          = local.common_tags
}
```

---

## 🎯 RESUMEN EJECUTIVO

### **TU REPO QUEDARÁ ASÍ: 17 archivos**
```
✅ 10 archivos que YA tienes
🆕 6 archivos CRÍTICOS que debes crear
🆕 1 archivo OPCIONAL (cloudwatch.tf) pero impresiona
