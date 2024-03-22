import { Router, Request, Response } from "express";
import { generateOpenAiResponsesController } from "../controllers/generate_open_ai_controller";

const openAiRouter = Router();

openAiRouter.post("/", generateOpenAiResponsesController);

export default openAiRouter;
