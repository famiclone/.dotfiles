import * as fs from 'fs';
/* Types */
interface RequestMessage {
  id: number | string;
  method: string;
  params?: object;
  jsonrpc: string;
}

type ServerCapabilities = Record<string, unknown>;

interface InitializeResult {
  capabilities: ServerCapabilities;

  serverInfo?: {
    name: string;
    version?: string;
  };
}

type CompletionItem = {
  label: string;
}

interface CompletionList {
  isIncomplete: boolean;
  items: CompletionItem[];
}

type HoverResult = {
  value: string;
}

interface HoverParams {
  textDocument: string;
  position: {
    line: number;
    character: number;
  };
}

/* Log */
const log = fs.createWriteStream('/tmp/lsp.log');
const logger = {
  write: (message: object | unknown) => {
    if (typeof message === 'object') {
      log.write(JSON.stringify(message));
    } else {
      log.write(message);
    }
    log.write('\n');
  }
}

/* Methods */
const initialize = (message: RequestMessage): InitializeResult => {
  return {
    capabilities: {
      completionProvider: {},
      hoverProvider: true,
    },
    serverInfo: {
      name: 'garden-lsp',
      version: '0.0.1'
    }
  }
};
const completion = (message: RequestMessage): CompletionList | null => {
  const { params } = message;

  const items: CompletionItem[] = [
    { label: 'foo' },
    { label: 'bar' },
  ];

  return {
    isIncomplete: false,
    items,
  };
};

const hover = (message: RequestMessage): HoverResult | null => {
  const { params } = message;

  logger.write(params);

  return {
    value: 'This is a hover result'
  };
}

/* Main */
let buffer = "";

process.stdin.on('data', (data) => {
  buffer += data;

  while (true) {
    const contentLengthMatch = buffer.match(/Content-Length: (\d+)\r\n/);
    if (!contentLengthMatch) break;

    const contentLength = parseInt(contentLengthMatch[1], 10);
    const messageStart = buffer.indexOf('\r\n\r\n') + 4;

    if (buffer.length < messageStart + contentLength) break;

    const message = JSON.parse(buffer.slice(messageStart, messageStart + contentLength));

    let result;
    if (message.method === 'initialize') {
      result = initialize(message);
      logger.write(result);
    } else if (message.method === 'textDocument/completion') {
      result = completion(message);
    } else if (message.method === 'textDocument/hover') {
      result = {value: 'This is a hover result'};
    }

    if (result) {
      const msg = JSON.stringify({
        id:message.id,
        result,
      });

      const length = Buffer.byteLength(msg, 'utf8');
      logger.write(`Content-Length: ${length}\r\n\r\n${msg}`);
      process.stdout.write(`Content-Length: ${length}\r\n\r\n${msg}`, 'utf8');
    }

    buffer = buffer.slice(messageStart + contentLength);
  }
});
