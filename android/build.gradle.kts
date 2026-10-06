allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    val configureAction = Action<Project> {
        if (plugins.hasPlugin("com.android.application") || plugins.hasPlugin("com.android.library")) {
            val androidExtension = extensions.findByName("android") as? com.android.build.gradle.BaseExtension
            if (androidExtension != null) {
                // Ensure namespace is set for AGP 8+ compatibility
                if (androidExtension.namespace == null) {
                    androidExtension.namespace = project.group.toString()
                }
                // Force legacy dependencies to compile using installed SDK 34 (or 35)
                androidExtension.compileSdkVersion(36)
            }
        }
    }

    if (state.executed) {
        configureAction.execute(this)
    } else {
        afterEvaluate(configureAction)
    }
}