# Service Validation Script
# Validates Docker Compose configurations, health checks, and README completeness

Write-Host "=== Docker Compose Services Validation ===" -ForegroundColor Cyan
Write-Host ""

$errorList = @()
$warningList = @()
$validatedServices = 0

# Find all docker-compose YAML files
$composeFiles = Get-ChildItem -Path . -Recurse -Include "*.yaml","*.yml" -Exclude "promtail-config.yaml","grafana-datasources.yaml","README.md" | Where-Object { 
    $_.Directory.Name -ne ".git" -and 
    $_.Directory.Name -ne ".github" -and
    $_.Directory.Name -ne "workflows" -and
    $_.Directory.Name -ne "config" -and
    $_.Name -notmatch "^(promtail|grafana|logstash|nginx)" 
}

Write-Host "Found $($composeFiles.Count) compose files to validate" -ForegroundColor Yellow
Write-Host ""

foreach ($file in $composeFiles) {
    $serviceName = $file.Directory.Parent.Name + "/" + $file.Directory.Name
    Write-Host "Validating: $serviceName" -ForegroundColor White
    
    # 1. Validate YAML syntax with docker compose config
    $output = docker compose -f $file.FullName config --quiet 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  [OK] YAML syntax valid" -ForegroundColor Green
        $validatedServices++
    } else {
        $errorList += "  [ERROR] $serviceName - YAML syntax error"
        Write-Host "  [ERROR] YAML syntax error" -ForegroundColor Red
    }
    
    # 2. Check for multi-service configurations (database dependencies)
    $content = Get-Content $file.FullName -Raw
    $hasDatabase = $content -match "postgres:|mysql:|mariadb:|mongodb:|redis:"
    $hasDependsOn = $content -match "depends_on:"
    
    if ($hasDatabase) {
        if ($hasDependsOn) {
            Write-Host "  [OK] Multi-service with proper dependencies" -ForegroundColor Green
        } else {
            $warningList += "  [WARN] $serviceName - Has database but no depends_on"
            Write-Host "  [WARN] Has database but no depends_on" -ForegroundColor Yellow
        }
    }
    
    # 3. Check for health checks
    $hasHealthCheck = $content -match "healthcheck:"
    if ($hasHealthCheck) {
        Write-Host "  [OK] Health check configured" -ForegroundColor Green
    } else {
        Write-Host "  [INFO] No health check configured" -ForegroundColor Gray
    }
    
    # 4. Check for README.md
    $readmePath = Join-Path $file.Directory.FullName "README.md"
    if (Test-Path $readmePath) {
        Write-Host "  [OK] README.md exists" -ForegroundColor Green
        
        # Check README completeness
        $readmeContent = Get-Content $readmePath -Raw
        $requiredSections = @("Quick Start", "Services", "Volumes")
        $missingSections = @()
        
        foreach ($section in $requiredSections) {
            if ($readmeContent -notmatch $section) {
                $missingSections += $section
            }
        }
        
        if ($missingSections.Count -eq 0) {
            Write-Host "  [OK] README has all required sections" -ForegroundColor Green
        } else {
            $warningList += "  [WARN] $serviceName - README missing sections: $($missingSections -join ', ')"
            Write-Host "  [WARN] README missing sections: $($missingSections -join ', ')" -ForegroundColor Yellow
        }
    } else {
        $errorList += "  [ERROR] $serviceName - README.md not found"
        Write-Host "  [ERROR] README.md not found" -ForegroundColor Red
    }
    
    # 5. Check for .env.example
    $envExamplePath = Join-Path $file.Directory.FullName ".env.example"
    if (Test-Path $envExamplePath) {
        Write-Host "  [OK] .env.example exists" -ForegroundColor Green
    } else {
        $warningList += "  [WARN] $serviceName - .env.example not found"
        Write-Host "  [WARN] .env.example not found" -ForegroundColor Yellow
    }
    
    Write-Host ""
}

# Summary
Write-Host "=== Validation Summary ===" -ForegroundColor Cyan
Write-Host "Total services validated: $validatedServices" -ForegroundColor White
Write-Host "Errors: $($errorList.Count)" -ForegroundColor $(if ($errorList.Count -eq 0) { "Green" } else { "Red" })
Write-Host "Warnings: $($warningList.Count)" -ForegroundColor $(if ($warningList.Count -eq 0) { "Green" } else { "Yellow" })
Write-Host ""

if ($errorList.Count -gt 0) {
    Write-Host "=== Errors ===" -ForegroundColor Red
    foreach ($err in $errorList) {
        Write-Host $err -ForegroundColor Red
    }
    Write-Host ""
}

if ($warningList.Count -gt 0) {
    Write-Host "=== Warnings ===" -ForegroundColor Yellow
    foreach ($warn in $warningList) {
        Write-Host $warn -ForegroundColor Yellow
    }
    Write-Host ""
}

if ($errorList.Count -eq 0) {
    Write-Host "[SUCCESS] All validations passed!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "[FAILED] Validation failed with $($errorList.Count) error(s)" -ForegroundColor Red
    exit 1
}
