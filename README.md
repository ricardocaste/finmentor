# Finmentor AI

# The problem FinMentor AI solves
Personal finance is already complicated for many people, and the world of cryptocurrencies adds an additional layer of complexity. FinMentor AI acts as a personal guide that listens to your conversations (through the OMI wearable) and offers contextual education and advice when it detects financial terms or concerns.

# Challenges we ran into
A primary challenge encountered during development was the relative scarcity of detailed backend integration examples and best practices within the OMI documentation, particularly for widely-used server-side languages such as Node.js, Java, and Dart. While the core API functionalities were documented, we found a lack of concrete, end-to-end code samples demonstrating how to robustly connect a backend application to the OMI system using well-defined, simple software architectures.

For instance, implementing FinMentor AI's core logic – which involves receiving analyzed conversation data from OMI, processing it to identify learning opportunities, and potentially interacting back with OMI (e.g., confirming a notification was sent or managing user preferences if stored off-chain) – required clear patterns for API communication, authentication, and data handling. The absence of solid examples in languages like Node.js (our preferred stack for rapid prototyping) or established enterprise languages like Java meant our team had to:

1. Invest significant time in interpretation: We spent extra cycles carefully dissecting the available API documentation and making educated inferences about expected request/response structures and optimal integration flows.
2. Engage in trial-and-error: We had to prototype several approaches for structuring the backend service calls to interact with OMI, increasing initial development time.
3. Develop abstractions from scratch: We needed to build our own service layers and client logic to interact with the OMI API based on our interpretation, rather than adapting existing, recommended patterns.

# How we got over it:

- Focused Abstraction: We designed a simple, abstracted service layer within our prototype backend (using Node.js) specifically for OMI interactions. This allowed us to isolate the OMI-specific communication logic, even without official architectural examples.
