# Content Management Service

This project is a Spring Boot application that provides a RESTful API for managing content items with MongoDB storage.

The Content Management Service allows users to create, read, update, and delete content items, as well as search for content based on tags or custom queries. It uses MongoDB for data persistence and provides a flexible structure for content items, including titles, tags, and body text.

The service is built using Spring Boot and leverages Spring Data MongoDB for database operations. It implements a layered architecture with controllers, services, and repositories, ensuring a clean separation of concerns and maintainable code structure.

## Repository Structure

```
content-service/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── content/
│   │   │           └── service/
│   │   │               ├── configuration/
│   │   │               ├── controller/
│   │   │               ├── dto/
│   │   │               ├── exception/
│   │   │               ├── listener/
│   │   │               ├── model/
│   │   │               ├── repository/
│   │   │               └── service/
│   │   └── resources/
│   │       └── application.yml
│   └── test/
│       └── java/
│           └── com/
│               └── content/
│                   └── service/
├── pom.xml
└── README.md
```

Key Files:
- `ContentServiceApplication.java`: The main entry point for the Spring Boot application.
- `ContentController.java`: REST controller handling HTTP requests for content management.
- `ContentService.java` and `ContentServiceImpl.java`: Service interface and implementation for content operations.
- `ContentRepository.java`: MongoDB repository interface for data access.
- `Content.java`: MongoDB document model representing a content item.
- `application.yml`: Configuration file for the Spring Boot application.

## Usage Instructions

### Installation

Prerequisites:
- Java 17 or later
- Maven 3.6 or later
- MongoDB 4.4 or later

Steps:
1. Clone the repository
2. Navigate to the project root directory
3. Run `mvn clean install` to build the project and run tests

### Getting Started

1. Ensure MongoDB is running on localhost:27017
2. Start the application:
   ```
   java -jar target/content-service-0.0.1-SNAPSHOT.jar
   ```
3. The service will be available at `http://localhost:8080`

### API Endpoints

- Create content: `POST /api/v1/content`
- Get content by ID: `GET /api/v1/content/{id}`
- Update content: `PUT /api/v1/content/{id}`
- Delete content: `DELETE /api/v1/content/{id}`
- Get all content: `GET /api/v1/content/`
- Search content: `GET /api/v1/content/search?query={query}`

### Example Usage

Creating a new content item:

```bash
curl -X POST http://localhost:8080/api/v1/content \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Sample Content",
    "tags": ["sample", "test"],
    "body": "This is a sample content body."
  }'
```

Response:
```json
{
  "id": "60f1a5b3e6b3f52d8c0d7e1f",
  "title": "Sample Content",
  "tags": ["sample", "test"],
  "body": "This is a sample content body.",
  "createdTimestamp": "2023-07-16T10:30:15",
  "modifiedTimestamp": "2023-07-16T10:30:15"
}
```

### Configuration

The application can be configured using the `application.yml` file. Key configurations include:

```yaml
spring:
  data:
    mongodb:
      uri: mongodb://127.0.0.1:27017/content_db
```

Modify the MongoDB URI as needed for your environment.

### Troubleshooting

Common issues and solutions:

1. MongoDB Connection Issues
   - Problem: Application fails to start with MongoDB connection errors
   - Solution: 
     1. Ensure MongoDB is running on the specified host and port
     2. Check the MongoDB URI in `application.yml`
     3. Verify network connectivity to the MongoDB server

2. Resource Not Found Errors
   - Problem: Requests return 404 Not Found for existing resources
   - Solution:
     1. Double-check the resource ID in the request URL
     2. Verify the resource exists in the database
     3. Check for any data migration issues

Debugging:
- Enable debug logging by adding `logging.level.com.content.service=DEBUG` to `application.yml`
- Check application logs in the console or log files for detailed error messages

## Data Flow

The Content Management Service follows a typical Spring MVC flow:

1. HTTP requests are received by the `ContentController`
2. The controller delegates to the `ContentService` for business logic
3. `ContentService` uses `ContentRepository` for database operations
4. Data is transferred using `ContentRequestDto` and `ContentResponseDto`
5. The `Content` entity is used for persistence in MongoDB

```
[Client] <-> [ContentController] <-> [ContentService] <-> [ContentRepository] <-> [MongoDB]
```

Key technical considerations:
- The service uses ModelMapper for DTO-Entity mapping
- MongoDB's document model allows for flexible content structure
- Custom exception handling is implemented for consistent error responses