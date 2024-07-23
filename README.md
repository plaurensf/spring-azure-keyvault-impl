# Inventory App - Accessing KeyVault secrets using KeyVault Property Source

For the **KeyVault Property Source** solution you'll need to add the Spring cloud dependency to your build.gradle/pom.xml file

    dependencies {  
	  implementation 'com.azure.spring:spring-cloud-azure-starter-keyvault:5.14.0'  
	}

Then, you'll need to define the KeyVault endpoint in the `application.yml/application.properties` file. It could be a reference to a ACA secret.

    application.yml 

	spring:
      cloud:
	   azure:
        keyvault.secret.property-sources[0].endpoint: ${key-vault-endpoint}

You just need to create the secret in the KeyVault and then reference it in the `application.yml/application.properties` file. Make sure the KeyVault secret has the same name as the reference in the property file.

    spring:
      inventory:
        password: ${inventory-app-secret}

Finally, you just need to use the `@Value` annotation on a variable and use it.

      public class ProductController {
          
          @Value(${spring.inventory.password})
          private final String password;
      
          @GetMapping
          public ResponseEntity<String> getListProducts(){
              return ResponseEntity.ok(password).getValue());
          }
      }
